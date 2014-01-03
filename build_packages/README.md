This directory contains scripts/definitions needed to build rpm packages which don't exist in standard repositories

Tools used here are:

  - mock - http://fedoraproject.org/wiki/Projects/Mock
    Creates chroot isolated environments to build packages in
    https://fedoraproject.org/wiki/Using_Mock_to_test_package_builds
  - fpm - https://github.com/jordansissel/fpm
    A simple to use package builder that can do rpm, deb and more
