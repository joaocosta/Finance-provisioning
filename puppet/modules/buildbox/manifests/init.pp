class buildbox {

    include buildbox::params

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
}
