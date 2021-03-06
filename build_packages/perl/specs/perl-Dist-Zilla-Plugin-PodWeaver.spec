Name:           perl-Dist-Zilla-Plugin-PodWeaver
Version:        3.102000
Release:        1%{?dist}
Summary:        Weave your Pod together from configuration and Dist::Zilla
License:        GPL+ or Artistic
Group:          Development/Libraries
URL:            http://search.cpan.org/dist/Dist-Zilla-Plugin-PodWeaver/
Source0:        http://www.cpan.org/modules/by-module/Dist/Dist-Zilla-Plugin-PodWeaver-%{version}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch:      noarch
BuildRequires:  perl(Dist::Zilla) >= 4
BuildRequires:  perl(Dist::Zilla::Role::FileFinderUser)
BuildRequires:  perl(Dist::Zilla::Role::FileMunger)
BuildRequires:  perl(ExtUtils::MakeMaker)
BuildRequires:  perl(File::Find::Rule)
BuildRequires:  perl(File::Spec)
BuildRequires:  perl(List::MoreUtils)
BuildRequires:  perl(Moose)
BuildRequires:  perl(namespace::autoclean)
BuildRequires:  perl(Pod::Elemental::PerlMunger)
BuildRequires:  perl(Pod::Weaver) >= 3.100710
BuildRequires:  perl(Pod::Weaver::Config::Assembler)
BuildRequires:  perl(PPI)
BuildRequires:  perl(Test::More) >= 0.96
Requires:       perl(Dist::Zilla) >= 4
Requires:       perl(Dist::Zilla::Role::FileFinderUser)
Requires:       perl(Dist::Zilla::Role::FileMunger)
Requires:       perl(List::MoreUtils)
Requires:       perl(Moose)
Requires:       perl(namespace::autoclean)
Requires:       perl(Pod::Elemental::PerlMunger)
Requires:       perl(Pod::Weaver) >= 3.100710
Requires:       perl(Pod::Weaver::Config::Assembler)
Requires:       perl(PPI)
Requires:       perl(:MODULE_COMPAT_%(eval "`%{__perl} -V:version`"; echo $version))

%description
[PodWeaver] is the bridge between Dist::Zilla and Pod::Weaver. It rips
apart your kinda-Pod and reconstructs it as boring old real Pod.

%prep
%setup -q -n Dist-Zilla-Plugin-PodWeaver-%{version}

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
* Fri Jan 03 2014 João Costa <joaocosta@zonalivre.org> 3.102000-1
- Specfile autogenerated by cpanspec 1.78.
