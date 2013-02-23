This directory contains scripts/definitions needed to build rpm packages which don't exist in standard repositories

Tools used here are:

  - mach - http://www.howtoforge.com/building-rpm-packages-in-a-chroot-environment-using-mach
    Creates chroot isolated environments to build packages in
  - fpm - https://github.com/jordansissel/fpm
    A simple to use package builder that can do rpm, deb and more


If mach build fails, try cleaning the build chroot:
  - mach clean
  - cp /etc/yum.repos.d/zonalivre.repo /var/lib/mach/states/fedora-16-x86_64-updates/yum/yum.repos.d/
