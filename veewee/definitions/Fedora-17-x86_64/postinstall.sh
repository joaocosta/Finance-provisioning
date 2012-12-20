#!/bin/sh

date > /etc/vagrant_box_build_time

VBOX_VERSION=$(cat /home/vagrant/.vbox_version)

yum -y update

yum -y install \
  ruby \
  ruby-devel \
  puppet \
  git \
  rubygems \
  rubygem-erubis \
  rubygem-highline \
  rubygem-json \
  rubygem-mime-types \
  rubygem-net-ssh \
  rubygem-polyglot \
  rubygem-rest-client \
  rubygem-treetop \
  rubygem-uuidtools \
  cfengine

cd /tmp
wget http://download.virtualbox.org/virtualbox/$VBOX_VERSION/VBoxGuestAdditions_$VBOX_VERSION.iso
mount -o loop,ro VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm VBoxGuestAdditions_$VBOX_VERSION.iso

gem install chef --no-rdoc --no-ri

# Zero out the free space to save space in the final image:
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY


exit

# EOF
