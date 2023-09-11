#!/usr/bin/env bash

. $(dirname $0)/demo.conf

[[ $EUID -eq 0 ]] && exit_on_error "Must not run as root"

[ "$#" -ne 1 -o ! -f "$1" ] && exit_on_error "Usage: $(basename $0) <TOML-FILE>"

cat >> "$1" << EOF

[[customizations.user]]
name = "${RHEL_USER}"
description = "Admin User"
password = "${RHEL_PASS_HASH}"
groups = ["wheel"]
EOF
