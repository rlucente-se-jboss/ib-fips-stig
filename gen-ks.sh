#!/usr/bin/env bash

. $(dirname $0)/demo.conf

[[ $EUID -eq 0 ]] && exit_on_error "Must not run as root"

EDGE_HASH="$(openssl passwd -6 ${EDGE_PASS})"
cat > pre-stig.ks << EOF
##
## Initial ostree install
##

# set locale defaults for the Install
lang en_US.UTF-8
keyboard us
timezone UTC

# initialize any invalid partition tables and destroy all of their contents
zerombr

# erase all disk partitions and create a default label
clearpart --all --initlabel

# automatically create xfs partitions with no LVM and no /home partition
autopart --type=plain --fstype=xfs --nohome

# poweroff after installation is successfully completed
poweroff

# installation will run in text mode
text

# activate network devices and configure with DHCP
network --bootproto=dhcp --noipv6

# Kickstart requires that we create a default user with sudo privileges
user --name=${EDGE_USER} --groups=wheel --iscrypted --password=${EDGE_HASH} --homedir=/var/home/core

# set up the OSTree-based install with disabled GPG key verification, the base
# URL to pull the installation content, 'centos' as the management root in the
# repo, and 'centos/8/x86_64/edge' as the branch for the installation
ostreesetup --nogpg --url=http://${HOSTIP}:8000/repo/ --osname=centos --remote=edge --ref=centos/9/x86_64/edge

EOF
