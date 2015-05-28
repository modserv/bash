#!/bin/sh

_MYSQLUP=`mysql -e 'SHOW STATUS;' | grep -i uptime | head -1 | awk {' print $2 '}`
echo "scale=2; $_MYSQLUP / 60 / 60" | bc | awk '{printf "%.2f\n", $0}'
