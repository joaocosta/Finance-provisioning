class buildbox::params {

    if $::osfamily == 'redhat' or $::operatingsystem == 'amazon' {
        $build_packages     = ['gcc', 'gcc-c++', 'make', 'perl-Dist-Zilla', 'mach', 'cpanspec']
    } elsif $::osfamily == 'debian' {
        $build_packages     = ['build-essential', 'libdist-zilla-perl', 'dh-make-perl']
    } else {
        fail("Class['buildbox::params']: Unsupported operatingsystem: $operatingsystem")
    }
}
