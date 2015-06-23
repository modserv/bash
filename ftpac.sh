#!/bin/bash
# FTPAC v1.0 (FTP Account Creator) script coded by Mohamed Magdy "ModServ, LLC. - www.modserv.com.eg"
#####################################################################################################

# Ensure the executer has root privileges
if [ "$(whoami)" != "root" ]; then
        echo "We are sorry but FTPAC v1.0 must be executed as root"
        exit 1
fi

# Ensure that all standard paths are exported
export PATH='/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin'


# Checking for cPanel existence
if [ -f /usr/local/cpanel/cpanel ]; then
	echo -e '\E[37m'"\033[1mcPanel is installed. [ Version: `cat /usr/local/cpanel/version` ] \033[0m"
	else
	echo -e '\E[37m'"\033[1mFTPAC v1.0 Can't run without cPanel, Exiting \033[0m"
	exit
	rm -rf $0
fi

# Let's get some details
echo -ne '\E[37'"\033[1mPlease enter your cPanel username: \033[0m"
read CPUSER
echo -ne '\E[37'"\033[1mPlease enter FTP folder name: \033[0m"
read FTPFOLDER
echo -ne '\E[37'"\033[1mPlease enter desired FTP Username: \033[0m"
read FTPUSER
echo -ne '\E[37'"\033[1mPlease enter desired FTP Password: \033[0m"
read FTPPASS

# Getting UID & GID of the username
CPUID=`grep $CPUSER /etc/passwd | cut -d":" -f3`
CPGID=`grep $CPUSER /etc/passwd | cut -d":" -f4`

# Creating directory for FTP Account
mkdir /home/$CPUSER/public_html/$FTPFOLDER

# Changing UID & GID of the created directory
chown -R $CPUSER:$CPUSER /home/$CPUSER/public_html/$FTPFOLDER

# Creating FTP account
/usr/local/cpanel/bin/proftpd_passwd $CPUSER -a $FTPUSER:$FTPPASS:$CPUID:$CPGID:$CPUSER:/home/$CPUSER/public_html/$FTPFOLDER:/usr/local/cpanel/bin/noshell
echo

# Updating FTP changes
/usr/local/cpanel/bin/ftpupdate
echo

echo -e '\E[37'"\033[1mFTP account has been created successfully, Thanks for using FTPAC v1.0 by Mohamed Magdy \033[0m"
