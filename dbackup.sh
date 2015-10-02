#!/bin/bash
# DBackup v1.0 "Direct Backup" script coded by Mohamed Magdy "ModServ, LLC. - www.modserv.com.eg"
##################################################################################################
# Ensure that all standard paths are exported
export PATH='/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin'

#Identifying Binaries to check if exist
CHMOD=/bin/chmod
MV=/bin/mv
PKGACCT=/scripts/pkgacct

binarycheckfunc() {
   if [ ! -f $1 ]; then
      echo " $1 Don't exist!  Exiting."
      exit
   fi
}

checkall(){
        binarycheckfunc ${CHMOD}
        binarycheckfunc ${MV}
        binarycheckfunc ${PKGACCT}
}

checkall

#Giving the right permission to functions
${CHMOD} 755 $WGET $TAR $RM $CHMOD $MV $MKDIR

# Ensure the executer has root privileges
if [ "$(whoami)" != 'root' ]; then
        echo "We are sorry but DBackup "Direct Backup" v1.0 must be executed as root"
        exit 1
fi
# Writing Variables
IPADRS=`hostname -i`

# Proceeding with DBackup
echo " "
echo -e '\E[0;32m'"\033[1m                Welcome to DBackup \"Direct Backup\" v1.0    \033[0m"
echo -e '\E[0;33m'"\033[1m        Coded by Mohamed Magdy \"ModServ, LLC. - www.modserv.com.eg\"    \033[0m"
echo -e '\E[37'"\033[1mDBackup \"Direct Backup\" takes a backup of an account and provide you with the direct link to download \033[0m"
echo " "
echo -e '\E[37'"\033[1mPlease provide the username you want to take a backup to (ie: modserv) \033[0m"
read UNOM
echo -e '\E[37'"\033[1mProceeding with a backup to $UNOM \033[0m"
sleep 3
${PKGACCT} $UNOM
${CHMOD} 644 /home/cpmove-$UNOM.tar.gz
${MV} -f /home/cpmove-$UNOM.tar.gz /usr/local/apache/htdocs/
echo " "
echo -e '\E[1;36m'"\033[1mYour download link is: http://$IPADRS/cpmove-$UNOM.tar.gz \033[0m"
echo " "
echo -e '\E[0;32m'"\033[1mThank you for choosing DBackup \"Direct Backup\" v1.0    \033[0m"
echo " "
sleep 2
