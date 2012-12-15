class buildbox(
    $user,
) {
    include buildbox::params

    Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

    package { "ruby-devel":
        ensure      => latest,
    }

    package { "fpm":
        ensure      => latest,
        provider    => 'gem',
        require     => Package["ruby-devel"],
    }

    package { $buildbox::params::build_packages:
        ensure      => latest,
    }

    package { $buildbox::params::perl_build:
        ensure      => latest,
    }

    package { $buildbox::params::perl_utils:
        ensure      => latest,
    }

    exec { "allow $user":
        command => "usermod -a -G mach $user",
        require => [Package["mach"], User[$user]],
    }
}

