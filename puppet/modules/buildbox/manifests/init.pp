class buildbox {
    package { "fpm":
        ensure      => latest,
        provider    => 'gem',
    }

    package { $buildbox::params::build_packages:
        ensure      => latest,
    }
}
