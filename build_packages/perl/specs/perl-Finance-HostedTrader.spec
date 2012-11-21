Name:           perl-Finance-HostedTrader
Version:        0.009
Release:        1%{?dist}
Summary:        Finance::HostedTrader Perl module
License:        MIT
Group:          Development/Libraries
URL:            http://search.cpan.org/dist/Finance-HostedTrader/
Source0:        http://www.cpan.org/modules/by-module/Finance/Finance-HostedTrader-%{version}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch:      noarch
BuildRequires:  perl(Config::Any)
BuildRequires:  perl(Date::Calc)
BuildRequires:  perl(Date::Manip)
BuildRequires:  perl(DBI)
BuildRequires:  perl(ExtUtils::MakeMaker)
BuildRequires:  perl(Finance::FXCM::Simple)
BuildRequires:  perl(Hash::Merge)
BuildRequires:  perl(HTML::Table)
BuildRequires:  perl(List::Compare::Functional)
BuildRequires:  perl(Log::Log4perl)
BuildRequires:  perl(MIME::Lite)
BuildRequires:  perl(Moose)
BuildRequires:  perl(Moose::Util::TypeConstraints)
BuildRequires:  perl(Params::Validate)
BuildRequires:  perl(Parse::RecDescent)
BuildRequires:  perl(Scalar::Util)
BuildRequires:  perl(Test::Differences)
BuildRequires:  perl(Test::Exception)
BuildRequires:  perl(Test::More)
BuildRequires:  perl(Text::ASCIITable)
BuildRequires:  perl(YAML::Syck)
BuildRequires:  perl(YAML::Tiny)
Requires:       perl(Config::Any)
Requires:       perl(Date::Calc)
Requires:       perl(Date::Manip)
Requires:       perl(DBI)
Requires:       perl(Finance::FXCM::Simple)
Requires:       perl(Hash::Merge)
Requires:       perl(HTML::Table)
Requires:       perl(List::Compare::Functional)
Requires:       perl(Log::Log4perl)
Requires:       perl(MIME::Lite)
Requires:       perl(Moose)
Requires:       perl(Moose::Util::TypeConstraints)
Requires:       perl(Params::Validate)
Requires:       perl(Parse::RecDescent)
Requires:       perl(Scalar::Util)
Requires:       perl(Test::Differences)
Requires:       perl(Test::More)
Requires:       perl(Text::ASCIITable)
Requires:       perl(YAML::Syck)
Requires:       perl(YAML::Tiny)
Requires:       perl(:MODULE_COMPAT_%(eval "`%{__perl} -V:version`"; echo $version))

%description
Finance::HostedTrader Perl module

%prep
%setup -q -n Finance-HostedTrader-%{version}

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
%doc Changes dist.ini LICENSE README weaver.ini
%{perl_vendorlib}/*
%{_mandir}/man3/*
%{_mandir}/man1/*
/usr/bin/AllTables.pl
/usr/bin/createDBSchema.pl
/usr/bin/dataUp2Date.pl
/usr/bin/eval.pl
/usr/bin/showConfig.pl
/usr/bin/synthetics.pl
/usr/bin/testData.pl
/usr/bin/testSignal.pl
/usr/bin/updateTf.pl


%changelog
* Wed Nov 21 2012 João Costa <joaocosta@zonalivre.org> 0.009-1
- Specfile autogenerated by cpanspec 1.78.