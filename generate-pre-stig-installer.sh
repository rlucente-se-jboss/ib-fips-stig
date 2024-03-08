#!/usr/bin/env bash

. $(dirname $0)/demo.conf

[[ $EUID -eq 0 ]] && exit_on_error "Must NOT run as root"

# build the Pre-STIG-ISO blueprint file
cat > pre-stig-installer.toml <<EOF
name = "Pre-STIG-ISO"
description = "Simplified Installer ISO for the Pre STIG rpm-ostree image"
version = "0.0.1"

[customizations]
fips = true
installation_device = "${EDGE_INSTALL_DEV}"

[[customizations.user]]
name = "${EDGE_USER}"
description = "Admin User"
password = "${EDGE_PASS_HASH}"
groups = ["wheel"]

EOF

# add the kernel customizations
grep -A1 customizations.kernel pre-stig-blueprint.toml \
    >> pre-stig-installer.toml

# add needed packages and append the remote for rpm-ostree updates for
# the edge device
cat >> pre-stig-blueprint.toml <<EOF
[[packages]]
name = "scap-security-guide"
version = "*"

[[customizations.files]]
path = "/etc/ostree/remotes.d/upstream.conf"
data = """
[remote "edge"]
url=http://${HOSTIP}:${HOSTPORT}/repo/
gpg-verify=false
"""
EOF
