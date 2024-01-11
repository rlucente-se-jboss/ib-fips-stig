# Image Builder with FIPS and STIG

## Pre-demo setup 
Start with a minimal install of RHEL 9.3 on baremetal or on a VM. Make
sure this repository is on your host using either `git clone` or secure
copy (`scp`).

During RHEL installation, configure a regular user with `sudo`
privileges on the host. These instructions assume that this repository is
cloned or copied to your user's home directory on the host.

Login to the host using `ssh`. Make sure that the username and password
are correct in the `demo.conf` file to authenticate to the
[Red Hat Customer Portal](https://access.redhat.com) and then run the
following script both to register and update the system.

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
### Generate the blueprint file
Generate the blueprint file to prepare the rpm-ostree image to comply
with some of the controls in the DISA STIG.

    oscap xccdf generate fix \
        --fetch-remote-resources \
        --profile xccdf_org.ssgproject.content_profile_stig \
        --fix-type blueprint /usr/share/xml/scap/ssg/content/ssg-rhel9-ds.xml \
	> pre-stig-blueprint.toml

### Cleanup the generated blueprint file
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

Finally, modify the following stanza, as shown below, since kdump and
autofs are not installed by default for an ostree type.

    [customizations.services]
    enabled = ["usbguard","sshd","chronyd","fapolicyd","firewalld","systemd-journald","rsyslog","auditd","pcscd"]
    # disabled = ["kdump","autofs","debug-shell"]
    disabled = ["debug-shell"]

### Build the rpm-ostree image
Push the modified blueprint and initiate the build of the rpm-ostree
image. The following commands will compose an rpm-ostree image. This
will be used to install the edge device.

    composer-cli blueprints push pre-stig-blueprint.toml
    composer-cli compose start-ostree xccdf_org.ssgproject.content_profile_stig edge-commit

Use the following command to monitor the build. The status will change
to FINISHED when the build completes.

    watch composer-cli compose status

Press CTRL-C to stop the above command.

### Generate the kickstart file
This simple script creates the kickstart file to install the rpm-ostree
image.

    ./gen-ks.sh

### Prepare the boot ISO
As a workaround to enable FIPS mode, we'll modify an existing
RHEL 9.3 boot ISO to include the generated kickstart and updated
kernel command line parameters. First, download the [RHEL 9.3 boot ISO](https://access.redhat.com/downloads/content/rhel).

Modify the ISO using the following commands to extract the kernel boot
parameters from the generated blueprint file and point to the correct
host to pull the rpm-ostree content.

    . demo.conf
    KERNEL_ARGS="$(grep -A1 kernel pre-stig-blueprint.toml | \
        grep append | cut -d\" -f2)"
    KERNEL_ARGS="$KERNEL_ARGS fips=1"

    sudo mkksiso \
        -c "${KERNEL_ARGS}" \
        --ks pre-stig.ks \
        /path/to/rhel-9.3-x86_64-boot.iso \
        pre-stig.iso
    sudo chown $USER: pre-stig.iso

In the above commands, `/path/to/` should match the file path to
the directory holding the downloaded boot ISO. The HOSTIP value is
determined by the `demo.conf` file and it should match the IP address
of the image-builder host. Make sure this value is correct in the
`demo.conf` file.

### Host the rpm-ostree content
Create a directory to hold the kickstart and the rpm-ostree compose for
installation to the edge device.

    mkdir ~/pre-stig-content
    cd ~/pre-stig-content

Download the built rpm-ostree image content. If there is only one compose,
you can simply hit TAB to get the UUID. Otherwise, determine the UUID
by listing the finished composes.

    composer-cli compose status
    composer-cli compose image IMAGE-UUID

Expand the rpm-ostree content and launch a very simple local web server
to provide the rpm-ostree content to support edge device installs.

    tar xvf IMAGE-UUID-commit.tar
    python3 -m http.server 8000

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
