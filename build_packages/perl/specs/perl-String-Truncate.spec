Name:           perl-String-Truncate
Version:        1.100601
Release:        1%{?dist}
Summary:        String::Truncate Perl module
License:        GPL+ or Artistic
Group:          Development/Libraries
URL:            http://search.cpan.org/dist/String-Truncate/
Source0:        http://www.cpan.org/modules/by-module/String/String-Truncate-%{version}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch:      noarch
BuildRequires:  perl(Carp)
BuildRequires:  perl(ExtUtils::MakeMaker)
BuildRequires:  perl(File::Spec)
BuildRequires:  perl(Sub::Exporter) >= 0.953
BuildRequires:  perl(Sub::Exporter::Util)
BuildRequires:  perl(Sub::Install) >= 0.03
BuildRequires:  perl(Test::More) >= 0.96
Requires:       perl(Carp)
Requires:       perl(Sub::Exporter) >= 0.953
Requires:       perl(Sub::Exporter::Util)
Requires:       perl(Sub::Install) >= 0.03
Requires:       perl(:MODULE_COMPAT_%(eval "`%{__perl} -V:version`"; echo $version))

%description
String::Truncate Perl module

%prep
%setup -q -n String-Truncate-%{version}

%build
%{__perl} Makefile.PL INSTALLDIRS=vendor
make %{?_smp_mflags}

%install
rm -rf $RPM_BUILD_ROOT

make pure_install PERL_INSTALL_ROOT=$RPM_BUILD_ROOT

find $RPM_BUILD_ROOT -type f -name .packlist -exec rm -f {} \;
find $RPM_BUILD_ROOT -depth -type d -exec rmdir {} 2>/dev/null \;

%{_fixperms} $RPM_BUILD_ROOT/*

%check
make test

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
%doc Changes dist.ini LICENSE META.json README
%{perl_vendorlib}/*
%{_mandir}/man3/*

%changelog
* Fri Jan 03 2014 João Costa <joaocosta@zonalivre.org> 1.100601-1
- Specfile autogenerated by cpanspec 1.78.
