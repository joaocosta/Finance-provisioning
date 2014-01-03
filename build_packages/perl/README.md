Build with mock

MODS="Devel::SimpleTrace Dist::Zilla::Plugin::Config::Git Dist::Zilla::Role::GitConfig Version::Next"

rm ~/rpmbuild/{SOURCES,SRPMS}/*
wget -P ~/rpmbuild/SOURCES/ `/opt/src/Finance-provisioning/build_packages/perl/cpan_source_download_url $MODS`
for file in ~/rpmbuild/SOURCES/*.tar.gz; do cpanspec $file; done
rpmbuild -bs *spec

foreach SRPM ~/rpmbuild/SRPMS/*src.rpm; do
  mock rebuild --no-clean $SRPM

  rm /var/lib/mock/fedora-20-x86_64/result/*.src.rpm
  foreach RPM /var/lib/mock/fedora-20-x86_64/result/*.rpm; do
    mock install $RPM && rm $RPM
  done

done




### Old stuff about using mach
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

To build a package manually:
  - mach build $SPECFILE
  - find /var/tmp/mach/fedora-16-x86_64-updates -name "*rpm" -exec mv -v {} ~/rpmbuild/RPMS/noarch \;
  - createrepo ~/rpmbuild/RPMS/noarch

If mach build fails, try cleaning the build chroot:
  - mach clean
  - cp /etc/yum.repos.d/zonalivre.repo /var/lib/mach/states/fedora-16-x86_64-updates/yum/yum.repos.d/
  - Now try "mach build" again

To build a package which will be a dependency of something else you want to build
  - Follow instructions as above, after it's done, run: mach yum clean all
