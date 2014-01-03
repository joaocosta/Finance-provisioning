#platform=x86, AMD64, or Intel EM64T
#version=DEVEL
# Install OS instead of upgrade
install
# Keyboard layouts
keyboard --vckeymap=uk --xlayouts='gb','uk'
# Poweroff after installation
poweroff
# Root password
rootpw --plaintext password
# System timezone
timezone UTC
# Use network installation
url --url="http://download.fedoraproject.org/pub/fedora/linux/releases/20/Fedora/x86_64/os"
repo --name=updates
# System language
lang en_GB
# Firewall configuration
firewall --disabled
# Network information
network --onboot yes --bootproto=dhcp --device=ens3 --noipv6
network --hostname=devbox.zonalivre.org
# System authorization information
auth  --useshadow  --passalgo=sha512
# Use text mode install
text
# SELinux configuration
selinux --disabled
# Do not configure the X Window System
skipx
firstboot --disabled

ignoredisk --only-use=sda,sdb

# System bootloader configuration
bootloader --location=mbr --boot-drive=sda --timeout=0
# Clear the Master Boot Record
zerombr
# Partition clearing information
clearpart --all
# Disk partitioning information
part / --fstype="ext4" --grow --ondisk=sda --size=1
part /opt --fstype="ext4" --grow --ondisk=sdb --size=1

services --enabled network,sshd

%packages
@core
kernel
net-tools

-NetworkManager
-authconfig
-dracut-config-rescue
-firewalld
-biosdevname
-plymouth
-iprutils

%end

%post
yum -y update
%end
