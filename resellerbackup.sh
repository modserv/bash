#!/bin/bash

echo "What's the reseller username?"
read RESOWNER

for _users in `grep $RESOWNER /var/cpanel/users/* | cut -d":" -f1 | cut -d"/" -f 5 | uniq`
  do
    /usr/local/cpanel/scripts/pkgacct $_users
  done
