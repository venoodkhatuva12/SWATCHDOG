#!/bin/bash
#Script for installing swatch.
#Author: Vinod.N K
#Usage: SwatchDog Installation
#Distro : Linux -Centos, Rhel, and any fedora
#Check whether root user is running the script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

sudo yum install perl* --skip-broken -y
sudo yum install perl-CPAN wget gcc -y
cd /usr/share/
wget http://downloads.sourceforge.net/project/swatch/swatchdog/swatchdog-3.2.4.tar.gz
sudo tar -zxvf swatchdog-3.2.4.tar.gz
mv swatchdog-3.2.4 swatch
cd /usr/share/swatchdog/
sudo cpan -i Date::Format File::Tail
sudo cpan -i Date::Manip Date::Calc
sudo cpan -i Test::Inter Test::Pod Test::Pod::Coverage Module::Build
cp /root/.cpan/sources/authors/id/S/SB/SBECK/Date-Manip-* .
sudo tar -zxvf Date-Manip-*.tar.gz
cd /usr/share/swatchdog/Date-Manip-*
sudo perl Makefile.PL
sudo make install
cd /usr/share/swatchdog/
sudo perl Makefile.PL
sudo make install
read -p " What is the hostname of the server : " SERVER
echo " #Send an email for exception errors
watchfor   /^(.+?(exception).+)$/
        echo=red
        exec "echo '$1' | mail -s 'PLEASE INVESTIGATE $SERVER JAVA LOGS "EXCEPTIONS" ERRORS' user@domain.com "
        bell 2 " >> /etc/swatch.conf


