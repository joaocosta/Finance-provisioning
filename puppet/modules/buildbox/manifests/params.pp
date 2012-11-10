class buildbox::params {

    if $::osfamily == 'redhat' or $::operatingsystem = 'amazon' {
        $build_packages     = ['gcc', 'make', 'cpan2rpm']
    } elsif $::osfamily == 'debian' {
        $build_packages     = ['build-essential', 'dh-make-perl']
    } else {
        fail("Class['buildbox::params']: Unsupported operatingsystem: $operatingsystem");
    }
}
