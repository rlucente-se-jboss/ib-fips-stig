#!/usr/bin/env bash

#
# only enable these stig rules
#
RULES=( \
    harden_sshd_ciphers_openssh_conf_crypto_policy \
    disable_ctrlaltdel_burstaction \
    no_empty_passwords \
    sshd_disable_empty_passwords \
)

TMPFILE=tailor-$$.sh

#
# create script to generate a new tailored STIG profile
#
cat > $TMPFILE <<'EOF'
autotailor \
    --output ssg-cs9-ds-tailoring-high-only.xml \
    --new-profile-id xccdf_org.ssgproject.content_profile_stig_high_only \
EOF

#
# disable all the rules in the STIG profile
#
for i in $(xmlstarlet sel -N "xccdf=http://checklists.nist.gov/xccdf/1.2" \
  -t -v \
  "//xccdf:Profile[@id='xccdf_org.ssgproject.content_profile_stig']/xccdf:select[@selected='true']/@idref" \
  /usr/share/xml/scap/ssg/content/ssg-rhel9-ds.xml | \
  sed 's/xccdf_org.ssgproject.content_rule_//g' )
do
  echo "    -u $i \\" >> $TMPFILE
done

#
# enable only these rules
#
for rule in ${RULES[@]}
do
    sed -i "/.*$rule .*/d" $TMPFILE
    echo "    -s $rule \\" >> $TMPFILE
done

#
# provide the source datastream and profile
#
cat >> $TMPFILE <<'EOF'
    /usr/share/xml/scap/ssg/content/ssg-cs9-ds.xml \
    xccdf_org.ssgproject.content_profile_stig
EOF

chmod +x $TMPFILE

./$TMPFILE

rm -fr $TMPFILE
