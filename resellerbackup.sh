#!/bin/bash
# Take a backup for a reseller account by only providing reseller username

echo "What's the reseller username?"
read RESOWNER

for _users in `grep $RESOWNER /var/cpanel/users/* | cut -d":" -f1 | cut -d"/" -f 5 | uniq`
  do
    /usr/local/cpanel/scripts/pkgacct $_users
  done
