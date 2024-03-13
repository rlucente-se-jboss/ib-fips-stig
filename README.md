# Image Builder with FIPS and STIG
This project shows how to install rpm-ostree content to an edge device
where National Institute of Standards and Technology (NIST) Federal
Information Processing Standards (FIPS) 140-3 validated cryptography
and Defense Information Systems Agency (DISA) Security Technical
Implementation Guide (STIG) controls are applied. The controls within
the DISA STIG are tailored only to CAT I rules.

## Pre-demo setup 
Start with a minimal install of CentOS Stream 9 on baremetal or on a
VM. Make sure this repository is on your host using either `git clone`
or secure copy (`scp`).

During CentOS Stream installation, configure a regular user with
`sudo` privileges on the host. These instructions assume that this
repository is cloned or copied to your user's home directory on the host
(e.g. `~/ib-fips-stig`). The below instructions use that assumption.

Login to the host using `ssh` and then run the following script to update
the system.

    cd ~/ib-fips-stig
    sudo ./register-and-update.sh
    sudo reboot

After the system reboots, simply run the script to install and configure
image-builder:

    cd ~/ib-fips-stig
    sudo ./config-image-builder.sh
    
The above script installs and enables the web console and image builder.

Once you've run the above scripts successfully, setup is complete.

## Demo
### Generate the blueprint files
Generate the blueprint file to prepare the rpm-ostree image to comply with
controls in the DISA STIG. The list of controls will be tailored later.

    cd ~/ib-fips-stig
    oscap xccdf generate fix \
        --fetch-remote-resources \
        --profile xccdf_org.ssgproject.content_profile_stig \
        --fix-type blueprint /usr/share/xml/scap/ssg/content/ssg-cs9-ds.xml \
	> pre-stig-blueprint.toml

Use the following command to generate the blueprint file for the installer
ISO compose. Make sure that the parameters in the `demo.conf` file for
the target storage device on the edge host, the IP address and port
number for rpm-ostree updates, and the edge user credentials are correct.

    ./generate-pre-stig-installer.sh

### Adjust the blueprint files
The generated blueprint file, `pre-stig-blueprint.toml`, will need
some slight manual adjustments prior to composing the rpm-ostree and
ISO images.

Comment out the `customizations.kernel` stanza file since these are only
allowed for the ISO installer compose. The stanza should resemble the
following after being commented out:

    # [customizations.kernel]
    # append = "slub_debug=P page_poison=1 vsyscall=none pti=on audit_backlog_limit=8192 audit=1"

Remove the custom mountpoints since these are not supported for ostree
types. The following should be commented out as shown below.

    # [[customizations.filesystem]]
    # mountpoint = "/home" 
    # size = 1073741824
    # 
    # [[customizations.filesystem]]
    # mountpoint = "/tmp"
    # size = 1073741824
    # 
    # [[customizations.filesystem]]
    # mountpoint = "/var"
    # size = 3221225472
    # 
    # [[customizations.filesystem]]
    # mountpoint = "/var/log"
    # size = 5368709120
    # 
    # [[customizations.filesystem]]
    # mountpoint = "/var/log/audit"
    # size = 10737418240
    # 
    # [[customizations.filesystem]]
    # mountpoint = "/var/tmp"
    # size = 1073741824

Modify the following stanza, as shown below, file since kdump and autofs
are not installed by default for an ostree type.

    [customizations.services]
    enabled = ["usbguard","sshd","chronyd","fapolicyd","firewalld","systemd-journald","rsyslog","auditd","pcscd"]
    # disabled = ["kdump","autofs","debug-shell"]
    disabled = ["debug-shell"]

### Build the rpm-ostree image
Push the modified blueprints and initiate the compose of the rpm-ostree
image. This compose will be used to create the installer ISO.

    composer-cli blueprints push pre-stig-blueprint.toml
    composer-cli blueprints push pre-stig-installer.toml

    composer-cli compose start-ostree xccdf_org.ssgproject.content_profile_stig edge-container

Use the following command to monitor the build. The status will change
to FINISHED when the build completes.

    watch composer-cli compose status

Press CTRL-C to stop the above command.

### Build the ISO installer
Identify the UUID for the compose of the rpm-ostree container image.

    composer-cli compose status

To download the container image, type the following command. If this is
the only compose, you can simply hit TAB instead of typing the UUID.

    composer-cli compose image UUID

Import the container archive and run it to support the ISO installer compose.

    skopeo copy oci-archive:UUID-container.tar \
        containers-storage:localhost/pre-stig:latest
    podman run -d --rm -p 8080:8080 pre-stig

Launch the compose of the ISO installer using the previous rpm-ostree compose.

    composer-cli compose start-ostree Pre-STIG-ISO edge-installer \
        --url http://localhost:8080/repo

Use the following command to monitor the build. The status will change
to FINISHED when the compose completes.

    watch composer-cli compose status

Press CTRL-C to stop the above command.

### Generate the kickstart file
Now, generate the kickstart file for the ISO installer to automate the
install by removing all partitions and autopartitioning the disk. This
also disables kdump and enables the network to use DHCP.

Use the following command to identify the UUID of the ISO installer compose.

    composer-cli compose status

Download the ISO installer using the following command where UUID matches
the identifier for the installer compose.

    composer-cli compose image UUID

Create a new kickstart using a base kickstart file and then append the
existing kickstart content from the ISO installer.

    cp pre-stig.ks.orig pre-stig.ks
    osirrox -indev UUID-installer.iso -concat append pre-stig.ks /osbuild.ks
   
where UUID matches the UUID of the composed ISO installer.
 
### Prepare the boot ISO
Modify the ISO installer to add the modified kickstart file and the
kernel arguments.

    . demo.conf
    sudo mkksiso \
        -c "$KERNEL_ARGS" \
        --ks pre-stig.ks \
        UUID-installer.iso \
        pre-stig.iso
    sudo chown $USER: pre-stig.iso

Again, UUID matches the UUID of the composed ISO installer.

### Install the edge device
Boot an edge device using the `pre-stig.iso` installer. The installation
should occur automatically without user intervention. You can push ENTER
to kick things off if you don't want to wait for the boot delay to expire.

## Evaluate the edge device against the STIG
Wait for the edge device to reboot following the installation.

### Generate a tailoring file
When doing STIG evaluations, the rules being applied can be tailored to
specific controls. The following script uses the `autotailor` command
to limit the remediation to a handful of high severity rules. On the
image-builder host, run the following command to create the tailoring file.

    cd ~/ib-fips-stig
    ./generate-tailor-file.sh

Copy the generated file, `ssg-cs9-ds-tailoring-high-only.xml`, to the
edge device.

### Evaluate before any remediation
Log in using the credentials defined in the `demo.conf` file and then
use the following command to generate a STIG evaluation report before
any remediation occurs.

    sudo oscap xccdf eval \
        --fetch-remote-resources \
        --report stig_report_pre_remediation.html \
        --profile xccdf_org.ssgproject.content_profile_stig \
        /usr/share/xml/scap/ssg/content/ssg-cs9-ds.xml

You can then download the generated `stig_report_pre_remediation.html`
file to review it.

### Remediate using the tailoring file
Remediate the high severity STIG failures by using the tailoring file. Use
the following commands to apply the remediations and reboot the system.

    sudo oscap xccdf eval \
        --fetch-remote-resources \
        --remediate \
        --tailoring-file ssg-cs9-ds-tailoring-high-only.xml \
        --profile xccdf_org.ssgproject.content_profile_stig_high_only \
        /usr/share/xml/scap/ssg/content/ssg-cs9-ds.xml

    sudo reboot

### Re-evaluate after the remediation
Log back in to the edge device and then use the following command to
generate a STIG evaluation report after the remediation has run.

    sudo oscap xccdf eval \
        --fetch-remote-resources \
        --report stig_report_post_remediation.html \
        --profile xccdf_org.ssgproject.content_profile_stig \
        /usr/share/xml/scap/ssg/content/ssg-cs9-ds.xml

You can then download the generated `stig_report_post_remediation.html`
file to review it.

### Summary
Both the [pre](stig_report_pre_remediation.html) and
[post](stig_report_post_remediation.html) STIG reports are included with
this github repository, but your mileage may vary.
