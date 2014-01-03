Name:           perl-Dist-Zilla-Plugin-Git
Version:        2.019
Release:        1%{?dist}
Summary:        Update your git repository after release
License:        GPL+ or Artistic
Group:          Development/Libraries
URL:            http://search.cpan.org/dist/Dist-Zilla-Plugin-Git/
Source0:        http://www.cpan.org/modules/by-module/Dist/Dist-Zilla-Plugin-Git-%{version}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch:      noarch
BuildRequires:  perl >= 0:5.010
BuildRequires:  perl(constant)
BuildRequires:  perl(Cwd)
BuildRequires:  perl(DateTime)
BuildRequires:  perl(Devel::SimpleTrace)
BuildRequires:  perl(Dist::Zilla) >= 4
BuildRequires:  perl(Dist::Zilla::File::InMemory)
BuildRequires:  perl(Dist::Zilla::Plugin::Config::Git)
BuildRequires:  perl(Dist::Zilla::Plugin::GatherDir) >= 4.200016
BuildRequires:  perl(Dist::Zilla::Role::AfterBuild)
BuildRequires:  perl(Dist::Zilla::Role::AfterMint)
BuildRequires:  perl(Dist::Zilla::Role::AfterRelease)
BuildRequires:  perl(Dist::Zilla::Role::BeforeRelease)
BuildRequires:  perl(Dist::Zilla::Role::FilePruner)
BuildRequires:  perl(Dist::Zilla::Role::GitConfig)
BuildRequires:  perl(Dist::Zilla::Role::PluginBundle)
BuildRequires:  perl(Dist::Zilla::Role::Releaser)
BuildRequires:  perl(Dist::Zilla::Role::VersionProvider)
BuildRequires:  perl(Dist::Zilla::Tester)
BuildRequires:  perl(Encode)
BuildRequires:  perl(Exporter)
BuildRequires:  perl(File::chdir)
BuildRequires:  perl(File::Copy::Recursive)
BuildRequires:  perl(File::Path) >= 2.07
BuildRequires:  perl(File::pushd)
BuildRequires:  perl(File::Spec)
BuildRequires:  perl(File::Spec::Functions)
BuildRequires:  perl(File::Temp)
BuildRequires:  perl(File::Which)
BuildRequires:  perl(Git::Wrapper) >= 0.021
BuildRequires:  perl(IPC::System::Simple)
BuildRequires:  perl(List::AllUtils)
BuildRequires:  perl(List::Util)
BuildRequires:  perl(Log::Dispatchouli)
BuildRequires:  perl(Module::Build)
BuildRequires:  perl(Module::Runtime)
BuildRequires:  perl(Moose)
BuildRequires:  perl(Moose::Autobox)
BuildRequires:  perl(Moose::Role)
BuildRequires:  perl(Moose::Util::TypeConstraints)
BuildRequires:  perl(MooseX::AttributeShortcuts)
BuildRequires:  perl(MooseX::Has::Sugar)
BuildRequires:  perl(MooseX::Types::Moose)
BuildRequires:  perl(MooseX::Types::Path::Class)
BuildRequires:  perl(namespace::autoclean) >= 0.09
BuildRequires:  perl(Path::Class) >= 0.22
BuildRequires:  perl(Path::Class::Dir)
BuildRequires:  perl(String::Formatter)
BuildRequires:  perl(Test::DZil)
BuildRequires:  perl(Test::Fatal) >= 0.006
BuildRequires:  perl(Test::More) >= 0.88
BuildRequires:  perl(Try::Tiny)
BuildRequires:  perl(version) >= 0.80
BuildRequires:  perl(Version::Next)
Requires:       perl(constant)
Requires:       perl(Cwd)
Requires:       perl(DateTime)
Requires:       perl(Dist::Zilla) >= 4
Requires:       perl(Dist::Zilla::Plugin::GatherDir) >= 4.200016
Requires:       perl(Dist::Zilla::Role::AfterBuild)
Requires:       perl(Dist::Zilla::Role::AfterMint)
Requires:       perl(Dist::Zilla::Role::AfterRelease)
Requires:       perl(Dist::Zilla::Role::BeforeRelease)
Requires:       perl(Dist::Zilla::Role::FilePruner)
Requires:       perl(Dist::Zilla::Role::GitConfig)
Requires:       perl(Dist::Zilla::Role::PluginBundle)
Requires:       perl(Dist::Zilla::Role::VersionProvider)
Requires:       perl(File::chdir)
Requires:       perl(File::Spec)
Requires:       perl(File::Spec::Functions)
Requires:       perl(File::Temp)
Requires:       perl(Git::Wrapper) >= 0.021
Requires:       perl(IPC::System::Simple)
Requires:       perl(List::AllUtils)
Requires:       perl(List::Util)
Requires:       perl(Module::Runtime)
Requires:       perl(Moose)
Requires:       perl(Moose::Autobox)
Requires:       perl(Moose::Role)
Requires:       perl(Moose::Util::TypeConstraints)
Requires:       perl(MooseX::AttributeShortcuts)
Requires:       perl(MooseX::Has::Sugar)
Requires:       perl(MooseX::Types::Moose)
Requires:       perl(MooseX::Types::Path::Class)
Requires:       perl(namespace::autoclean) >= 0.09
Requires:       perl(Path::Class) >= 0.22
Requires:       perl(Path::Class::Dir)
Requires:       perl(String::Formatter)
Requires:       perl(Try::Tiny)
Requires:       perl(version) >= 0.80
Requires:       perl(Version::Next)
Requires:       perl(:MODULE_COMPAT_%(eval "`%{__perl} -V:version`"; echo $version))

%description
This set of plugins for Dist::Zilla can do interesting things for module
authors using Git (http://git-scm.com) to track their work. The following
plugins are provided in this distribution:

%prep
%setup -q -n Dist-Zilla-Plugin-Git-%{version}

%build
%{__perl} Build.PL installdirs=vendor
./Build

%install
rm -rf $RPM_BUILD_ROOT

./Build install destdir=$RPM_BUILD_ROOT create_packlist=0
find $RPM_BUILD_ROOT -depth -type d -exec rmdir {} 2>/dev/null \;

%{_fixperms} $RPM_BUILD_ROOT/*

%check
./Build test

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
%doc AUTHOR_PLEDGE Changes corpus dist.ini LICENSE META.json README
%{perl_vendorlib}/*
%{_mandir}/man3/*

%changelog
* Fri Jan 03 2014 João Costa <joaocosta@zonalivre.org> 2.019-1
- Specfile autogenerated by cpanspec 1.78.
