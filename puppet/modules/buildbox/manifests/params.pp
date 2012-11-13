class buildbox::params {

    if $::osfamily == 'redhat' or $::operatingsystem == 'amazon' {
        $build_packages     = ['gcc', 'gcc-c++', 'make', 'mach', 'cpanspec']
        $perl_build         = ['perl-Dist-Zilla', 'perl-App-cpanminus']
    } elsif $::osfamily == 'debian' {
        $build_packages     = ['build-essential', 'dh-make-perl']
        $perl_build         = ['libdist-zilla-perl', 'libapp-cpanminus-perl']
    } else {
        fail("Class['buildbox::params']: Unsupported operatingsystem: $operatingsystem")
    }
}
