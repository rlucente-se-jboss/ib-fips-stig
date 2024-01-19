# Image Builder with FIPS and STIG

## Pre-demo setup 
Start with a minimal install of CentOS Stream 9 on baremetal or on a
VM. Make sure this repository is on your host using either `git clone`
or secure copy (`scp`).

During CentOS Stream installation, configure a regular user with `sudo`
privileges on the host. These instructions assume that this repository
is cloned or copied to your user's home directory on the host.

Login to the host using `ssh` and then run the following script to update
the system.

    cd /path/to/ib-fips-stig
    sudo ./register-and-update.sh
    sudo reboot

In the above commands, `/path/to/ib-fips-stig` should match the file
path to your `ib-fips-stig` directory.

After the system reboots, simply run the script to install image-builder:

    sudo ./config-image-builder.sh
    
The above script installs and enables the web console and image builder.

Once you've run the above scripts successfully, setup is complete.

## Demo
### Generate the blueprint files
Generate the blueprint file to prepare the rpm-ostree image to comply
with some of the controls in the DISA STIG.

    oscap xccdf generate fix \
        --fetch-remote-resources \
        --profile xccdf_org.ssgproject.content_profile_stig \
        --fix-type blueprint /usr/share/xml/scap/ssg/content/ssg-cs9-ds.xml \
	> pre-stig-blueprint.toml

Generate the blueprint file for the installer ISO compose. This makes
sure that FIPS mode is enabled on the edge device and it provides an
initial user during installation.

    . demo.conf
    envsubst '${EDGE_USER} ${EDGE_PASS_HASH}' \
        < pre-stig-installer.toml.orig > pre-stig-installer.toml

### Cleanup the initial compose blueprint file
The generated blueprint file `pre-stig-blueprint.toml` will need some
cleanup to build the rpm-ostree image.

Add the following stanza to the list of packages:

    [[packages]]
    name = "scap-security-guide"
    version = "*"

Comment out the following stanza, as shown below, since kernel boot
parameter customizations are not supported for ostree types.

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

Modify the following stanza, as shown below, since kdump and autofs are
not installed by default for an ostree type.

    [customizations.services]
    enabled = ["usbguard","sshd","chronyd","fapolicyd","firewalld","systemd-journald","rsyslog","auditd","pcscd"]
    # disabled = ["kdump","autofs","debug-shell"]
    disabled = ["debug-shell"]

Add the following stanza, shown below, to add a remote to the edge device
to pull updates from an upstream server.

    [[customizations.files]]
    path = "/etc/ostree/remotes.d/upstream.conf"
    data = """
    [remote "edge"]
    url=http://192.168.122.1/ostree/repo/
    gpg-verify=false
    """

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
existing kickstart content within the ISO installer.

    cp pre-stig.ks.org pre-stig.ks
    isoinfo -i UUID-installer.iso -x osbuild.ks >> pre-stig.ks
    
### Prepare the boot ISO
*** TODO update to incorporate the kickstart and command line args into the installer compose

Modify the ISO installer to append kernel command line parameters and
the modified kickstart file. Use the following commands to extract the
kernel boot parameters from the generated blueprint file.

    KERNEL_ARGS=$(grep -A1 customizations\.kernel pre-stig-blueprint.toml | \
        grep append | cut -d' ' -f3-)

Append the `KERNEL_ARGS` and replace the kickstart file in the installer
ISO using the following commands.

    sudo mkksiso \
        -c ${KERNEL_ARGS} \
        --ks pre-stig.ks \
        UUID-installer.iso \
        pre-stig.iso
    sudo chown $USER: pre-stig.iso

Again, UUID matches the UUID of the composed ISO installer.

### Install the edge device
Boot an edge device using the `pre-stig.iso` installer. The installation
should occur automatically without user intervention. You can push ENTER
to kick things off if you don't want to wait for the time to expire.

## Evaluate the edge device against the STIG
Wait for the edge device to reboot following the installation.

### Generate a tailoring file
When doing STIG evaluations, the rules being applied can be tailored to
specific controls. The following script uses the `autotailor` command
to limit the remediation to a handful of high severity rules. On the
image-builder host, run the following command to create the tailoring file.

    ./generate-tailor-file.sh

Copy the generated file, `ssg-rhel9-ds-tailoring-high-only.xml`, to the
edge device.

### Evaluate before any remediation
Log in using the credentials defined in the `demo.conf` file and then
use the following command to generate a STIG evaluation report before
any remediation occurs.

    sudo oscap xccdf eval \
        --report stig_report_pre_remediation.html \
        --profile xccdf_org.ssgproject.content_profile_stig \
        /usr/share/xml/scap/ssg/content/ssg-rhel9-ds.xml

You can then download the generated `stig_report_pre_remediation.html`
file to review it.

### Remediate using the tailoring file
Remediate the high severity STIG failures by using the tailoring file. Use
the following commands to apply the remediations and reboot the system.

    sudo oscap xccdf eval \
        --remediate \
        --tailoring-file ssg-rhel9-ds-tailoring-high-only.xml \
        --profile xccdf_org.ssgproject.content_profile_stig_high_only \
        /usr/share/xml/scap/ssg/content/ssg-rhel9-ds.xml

    sudo reboot

### Re-evaluate after the remediation
Log back in to the edge device and then use the following command to
generate a STIG evaluation report after the remediation has run.

    sudo oscap xccdf eval \
        --report stig_report_post_remediation.html \
        --profile xccdf_org.ssgproject.content_profile_stig \
        /usr/share/xml/scap/ssg/content/ssg-rhel9-ds.xml

You can then download the generated `stig_report_post_remediation.html`
file to review it.

### Summary
Both the [pre](stig_report_pre_remediation.html) and
[post](stig_report_post_remediation.html) STIG reports are included with
this github repository, but your mileage may vary.
