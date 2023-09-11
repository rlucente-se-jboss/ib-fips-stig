WIP These need to be updated quite a bit

# Image Builder with FIPS and STIG

## Pre-demo setup 
Start with a minimal install of RHEL on baremetal or on a VM. Make
sure this repository is on your RHEL host using either `git clone`
or secure copy (`scp`).

During RHEL installation, configure a regular user with `sudo`
privileges on the host. These instructions assume that this repository
is cloned or copied to your user's home directory on the RHEL host.

You'll need to customize the settings in the `demo.conf` script to
include your Red Hat Subscription Manager (RHSM) credentials to
login to the [customer support portal](https://access.redhat.com)
to pull updated content.

Login to the RHEL host using `ssh` and then run the first script
both to register and update the system.

    cd /path/to/ib-fips-stig
    sudo ./01-setup-rhel.sh
    reboot

After the system reboots, simply run the script to install image-builder:

    sudo ./02-config-image-builder.sh
    
The above scripts install and enable the web console and image builder.

Once you've run the above scripts successfully, setup is complete.

## Demo
Generate the blueprint file to apply the DISA STIG.

    oscap xccdf generate fix \
        --profile xccdf_org.ssgproject.content_profile_stig \
        --fix-type blueprint /usr/share/xml/scap/ssg/content/ssg-rhel9-ds.xml \
	> fips-stig-blueprint.toml

Update the blueprint file based on the environment variables to add an
adminstrative user.

    ./03-add-user.sh fips-stig-blueprint.toml

Push the blueprint file to image-builder and start building the image.

    composer-cli blueprints push fips-stig-blueprint.toml
    composer-cli compose start rhel-fips-stig qcow2

Wait until the build completes.

    watch composer-cli compose status

Download the built image. If there is only one image, you can simply
hit <TAB> to get the UUID of the image. Otherwise, determine the UUID
by listing the finished composes.

    composer-cli compose status
    composer-cli compose image <IMAGE-UUID>

