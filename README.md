# cdsw_install
Automated installed of CDSW with Director 2.3

This repo contains Director 2.3 configuration files that can be used to install a cluster to demonstrate CDSW.

The main configuration file is `cdsw.conf`. This file itself refers to another file:
* `aws.conf` - a file containing the provider configuration for Amazon Web Services
* `ssh.conf` - a file containing the details required to configure passwordless ssh access into the machines that director will create.

You will need to put in the appropriate values into `aws.conf` and `ssh.conf` before before you use these two files.

To use this set of files you need to put them all into the same directory then execute something like:
```sh
export AWS_SECRET_KEY=aldsfkja;sldfkj;adkf;adjkf
cloudera-director bootstrap-remote cdsw.conf --lp.remote.username=director --lp.remote.password=cloudera
```
Note the use of the AWS_SECRET_KEY envariable. If you fail to set that up then you'll get a validation error.

## Details
### Testing
The testing directory contains a simple set of test files that will replace the string `REPLACE_ME_XXXX` with `REPLACE_ME_XXXX_TEST`

## Limitations
Requires a kerberized cluster (not certain this is needed anymore, but `aws.conf.template` currently has kerberos in it.

Uses a fixed AMI that has AES256 JCE in it.

Only tested in AWS us-east-1 using the exact network etc. etc. as per the file.

Relies on an [xip.io](http://xip.io) trick to make it work.

## XIP.io tricks
(XIP.io)[http://xip.io] is a public bind server that uses the FQDN given to return an address. A simple explanation is if you have your kdc at IP address `10.3.4.6`, say, then you can refer to it as `kdc.10.3.4.6.xip.io` and this name will be resolved to `10.3.4.6` (indeed, `foo.10.3.4.6.xip.io` will likewise resolve to the same actual IP address).

This technique is used in two places:
+ In the director conf file to specify the IP address of the KDC - instead of messing around with bind or `/etc/hosts` in a bootstrap script etc. simply set the KDC_HOST to `kdc.A.B.C.D.xip.io` (choosing appropriate values for A, B, C & D as per your setup)
+ When the cluster is built you will access the CDSW at the public IP address of the CDSW instance. Lets assume that that address is `C.D.S.W` (appropriate, some might say) - then the URL to access that instance would be http://ec2.C.D.S.W.xip.io

This is great for hacking around with ephemeral devices such as VMs and Cloud images!
