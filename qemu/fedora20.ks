#platform=x86, AMD64, or Intel EM64T
#version=DEVEL
# Install OS instead of upgrade
install
# Keyboard layouts
keyboard 'uk'
# Reboot after installation
#reboot
halt
# Root password
rootpw --plaintext password
# System timezone
timezone Etc/GMT
# Use network installation
url --url="http://download.fedoraproject.org/pub/fedora/linux/releases/20/Fedora/x86_64/os"
# System language
lang en_GB
# Firewall configuration
firewall --disabled
# Network information
network  --bootproto=dhcp --device=ens3
# System authorization information
auth  --useshadow  --passalgo=sha512
# Use text mode install
text
# SELinux configuration
selinux --disabled
# Do not configure the X Window System
skipx
firstboot --disabled

# System bootloader configuration
bootloader --location=mbr --boot-drive=sda
# Clear the Master Boot Record
zerombr
# Partition clearing information
clearpart --all
# Disk partitioning information
part / --fstype="ext4" --grow --ondisk=sda --size=1
part /opt --fstype="ext4" --grow --ondisk=sdb --size=1

%packages
@core
-NetworkManager
-authconfig
-dracut-config-rescue
-firewalld

%end
