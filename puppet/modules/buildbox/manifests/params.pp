class buildbox::params {

    if $::osfamily == 'redhat' or $::operatingsystem == 'amazon' {
        $build_packages     = ['gcc', 'gcc-c++', 'make', 'mock', 'cpanspec', 'mariadb-devel', 'automake', 'autoconf', 'libtool', 'libforexconnect-devel']
        $perl_build         = ['perl-Dist-Zilla', 'perl-Dist-Zilla-Plugin-PodWeaver', 'perl-Term-UI', 'perl-Dist-Zilla-Plugin-Git', 'perl-Pod-Elemental-Transformer-List', 'perl-App-cpanminus', 'perl-Test-Exception']
        $perl_utils         = ['perl-Pod-Perldoc']
    } elsif $::osfamily == 'debian' {
        $build_packages     = ['build-essential', 'dh-make-perl']
        $perl_build         = ['libdist-zilla-perl', 'libapp-cpanminus-perl']
        $perl_utils         = []
    } else {
        fail("Class['buildbox::params']: Unsupported operatingsystem: $operatingsystem")
    }
}
