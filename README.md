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

After the system reboots, simply run the script to install image-builder:

    sudo ./config-image-builder.sh
    
The above script installs and enables the web console and image builder.

Once you've run the above scripts successfully, setup is complete.

## Demo
### Generate the blueprint file
Generate the blueprint file to apply the DISA STIG to the rpm-ostree
image from image-builder.

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

### Apply quick and dirty STIG remediations
Quick and dirty STIG remediations can be appended to the
blueprint file. These replace the entire contents of the file using
`customizations.files` stanzas even though a single line change would
be sufficient.

The remediations included here target all but two of the severity "high"
STIG findings. The remaining two require modifying the `/boot` partition
via the `grubby` command.

To append the STIG remediations, use the following command.

    cat severity-high-snippet.txt >> pre-stig-blueprint.toml

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

### Identify the kernel command line parameters
Review the generated blueprint file and identify the kernel command line
parameters. Find the following stanza in the `pre-stig-blueprint.toml`
file.

    # [customizations.kernel]
    # append = "slub_debug=P page_poison=1 vsyscall=none pti=on audit_backlog_limit=8192 audit=1"

When installing the edge device later, you'll add the above parameters to
the kernel command line plus the parameters to enable FIPS mode and pull
the remotely hosted kickstart file. The full list of kernel parameters
to be added is shown below.

    slub_debug=P page_poison=1 vsyscall=none pti=on audit_backlog_limit=8192 audit=1 fips=1 inst.ks=http://HOSTIP:8000/pre-stig.ks

The HOSTIP value should match the IP address of the image-builder
host. This value is conveniently calculated in the `demo.conf` file.

    . demo.conf
    echo $HOSTIP

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

Expand the rpm-ostree content and link to the kickstart file.

    tar xvf IMAGE-UUID-commit.tar
    ln -s /path/to/ib-fips-stig/pre-stig.ks .

Run a local web server to provide the rpm-ostree and kickstart content
to support edge device installs.

    python3 -m http.server 8000

### Install the edge device
Boot an edge device using a RHEL installation image. When
prompted to start the installation, press TAB and then add the kernel
command line parameters identified above. Hit ENTER to automate the
rest of the installation.

## Evaluate the edge device against the STIG
Once the edge device has rebooted, log in using the credentials defined
in the `demo.conf` file in this repository. Use the following command
to generate a STIG evaluation report.

    sudo oscap xccdf eval --report stig_report.html \
        --profile xccdf_org.ssgproject.content_profile_stig \
        /usr/share/xml/scap/ssg/content/ssg-rhel9-ds.xml

You can then download the generated `stig_report.html` file to review it.

An [example report](stig_report.html) is included with this github repository, but your
mileage may vary.
