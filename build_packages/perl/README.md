The get_packages.pl script does the following:

  - Fetch http://cpan.org/modules/02packages.details.txt.gz
  - Compare the packages in /home/joao/rpmbuild/RPMS/noarch with 02packages.details.txt.gz to see if there are any new/updated perl distributions that need to be built
  - Output to stdout a series of shell commands needed to create the packages
