class buildbox::params {

    if $::osfamily == 'redhat' or $::operatingsystem == 'amazon' {
        $build_packages     = ['gcc', 'gcc-c++', 'make', 'mach', 'cpanspec']
        $perl_build         = ['perl-Dist-Zilla', 'perl-Dist-Zilla-Plugin-AutoPrereqs', 'perl-Dist-Zilla-Plugin-PruneFiles', 'perl-Dist-Zilla-PluginBundle-Basic', 'perl-Dist-Zilla-PluginBundle-Filter']
    } elsif $::osfamily == 'debian' {
        $build_packages     = ['build-essential', 'dh-make-perl']
        $perl_build         = ['libdist-zilla-perl']
    } else {
        fail("Class['buildbox::params']: Unsupported operatingsystem: $operatingsystem")
    }
}
