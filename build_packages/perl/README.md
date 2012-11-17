The get_packages.pl script does the following:

  - Fetch http://cpan.org/modules/02packages.details.txt.gz
  - Compare the packages in /home/joao/rpmbuild/RPMS/noarch with 02packages.details.txt.gz to see if there are any new/updated perl distributions that need to be built
  - Output to stdout a series of shell commands needed to create the packages


If new/updated cpan distributions need to be built, the following stages apply:

  - Create specfile for newly download distribution
  - If this is an updated version of a previously built distribution, diff/merge the existing spec file
    - vimdiff quick reference: http://amjith.blogspot.co.uk/2008/08/quick-and-dirty-vimdiff-tutorial.html
  - Review the specfile (eg: Dependencies, Descriptions, etc ...)
  - Run mach to build the rpm. Address any errors that may occur.
  - If there are no errors and rpm was built, commit spec file.
  - Move the built packages from /var/tmp/mach to /home/joao/rpmbuild/RPMS/noarch
  - Recreate the repo at /home/joao/rpmbuild/RPMS/noarch
  - Remove distributions downloaded from cpan (to keep git status clean)
