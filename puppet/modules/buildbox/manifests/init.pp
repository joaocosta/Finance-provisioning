class buildbox {
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

    include users
    realize Users::Mkuser["joao"]

    exec { "allow joao":
        command => "usermod -a -G mach joao",
        require => [Package["mach"], User["joao"]],
    }

}

