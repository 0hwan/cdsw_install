#!/bin/bash -x

exec >~/bootstrap-cdsw.log 2>&1

cd /etc/yum.repos.d
cat - <<EOF >cloudera-cdsw.repo
[cloudera-cdsw]
# Packages for Cloudera's Distribution for data science workbench, Version 1, on RedHat	or CentOS 7 x86_64
name=Cloudera's Distribution for cdsw, Version 1
baseurl=https://archive.cloudera.com/cdsw/1/redhat/7/x86_64/cdsw/1/
gpgkey =https://archive.cloudera.com/cdsw/1/redhat/7/x86_64/cdsw/RPM-GPG-KEY-cloudera    
gpgcheck = 1
EOF
rpm --import https://archive.cloudera.com/cdsw/1/redhat/7/x86_64/cdsw/RPM-GPG-KEY-cloudera
yum -y install cloudera-data-science-workbench
