Name:           perl-Version-Next
Version:        0.002
Release:        1%{?dist}
Summary:        Increment module version numbers simply and correctly
License:        Apache Software License
Group:          Development/Libraries
URL:            http://search.cpan.org/dist/Version-Next/
Source0:        http://www.cpan.org/modules/by-module/Version/Version-Next-%{version}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch:      noarch
BuildRequires:  perl >= 0:5.006
BuildRequires:  perl(Carp)
BuildRequires:  perl(ExtUtils::MakeMaker)
BuildRequires:  perl(File::Temp)
BuildRequires:  perl(Sub::Exporter)
BuildRequires:  perl(Test::Exception) >= 0.29
BuildRequires:  perl(Test::More) >= 0.88
Requires:       perl(Carp)
Requires:       perl(Sub::Exporter)
Requires:       perl(:MODULE_COMPAT_%(eval "`%{__perl} -V:version`"; echo $version))

%description
This module provides a simple, correct way to increment a Perl module
version number. It does not attempt to guess what the original version
number author intended, it simply increments in the smallest possible
fashion. Decimals are incremented like an odometer. Dotted decimals are
incremented piecewise and presented in a standardized way.

%prep
%setup -q -n Version-Next-%{version}

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
* Fri Jan 03 2014 João Costa <joaocosta@zonalivre.org> 0.002-1
- Specfile autogenerated by cpanspec 1.78.
