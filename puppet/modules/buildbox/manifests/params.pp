class buildbox::params {

    if $::osfamily == 'redhat' or $::operatingsystem == 'amazon' {
        $build_packages     = ['gcc', 'gcc-c++', 'make', 'mach', 'cpanspec']
        $perl_build         = ['perl-Dist-Zilla', 'perl-Dist-Zilla-Plugin-PodWeaver', 'perl-Pod-Elemental-Transformer-List', 'perl-App-cpanminus', 'perl-Test-Exception']
        $perl_utils         = ['perl-Pod-Perldoc']

        file { "/var/lib/mach/states/fedora-16-x86_64-updates":
            ensure  => directory,
            group   => 'mach',
            mode    => '0775',
            require => Package['mach'],
        }

#TODO: these files need a user defined
        file { "/var/lib/mach/states/fedora-16-x86_64-updates/yum":
            ensure  => directory,
            group   => 'mach',
            mode    => '0775',
            require => File["/var/lib/mach/states/fedora-16-x86_64-updates"],
        }

        file { "/var/lib/mach/states/fedora-16-x86_64-updates/yum/yum.repos.d":
            ensure  => directory,
            group   => 'mach',
            mode    => '0775',
            require => File["/var/lib/mach/states/fedora-16-x86_64-updates/yum"],
        }

        file { "/var/lib/mach/states/fedora-16-x86_64-updates/yum/yum.repos.d/zonalivre.repo":
            ensure  => present,
            source  => 'puppet:///modules/zonalivre_repo/zonalivre.repo',
            group   => 'mach',
            mode    => '0644',
            require => File["/var/lib/mach/states/fedora-16-x86_64-updates/yum/yum.repos.d"],
        }
#END TODO
    } elsif $::osfamily == 'debian' {
        $build_packages     = ['build-essential', 'dh-make-perl']
        $perl_build         = ['libdist-zilla-perl', 'libapp-cpanminus-perl']
        $perl_utils         = []
    } else {
        fail("Class['buildbox::params']: Unsupported operatingsystem: $operatingsystem")
    }
}
