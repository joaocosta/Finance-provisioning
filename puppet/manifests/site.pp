Exec { path => [ '/usr/bin' ] }

stage { 'init':
    before  => Stage['main'],
}

class stage_init {
    zonalivre_repo::client { "site_zonalivre_repo": }

    file { '/etc/localtime':
        ensure  => link,
        target  => '/usr/share/zoneinfo/UTC',
    }

    package { 'selinux-policy-targeted':
        ensure  => absent,
    }

    package { 'selinux-policy':
        ensure  => absent,
        require => Package['selinux-policy-targeted'],
    }
}

class { 'stage_init':
    stage   => 'init',
}


node default {
    include users

    Users::Mkuser <| groups == 'users' |>
    #realize Users::Mkuser['apache']

    class { 'zonalivre_repo::server':
        base_path   => '/home/joao/rpmbuild',
        user        => 'joao',
        group       => 'apache',
    }

    class { 'fxtrader': }
    class { 'fxtrader::website': }

    package { ['vim-enhanced', 'screen']:
        ensure  => latest,
    }

    package { 'mock':
        ensure  => latest,
    }
}

node 'devbox.zonalivre.org' inherits 'default' {

    Users::Mkuser <| |>
    Users::Mkgroup <| name == 'mock' |>

    class { 'buildbox': }

    class { 'fxtrader::test': }

    package { ['strace', 'wget']:
        ensure  => latest,
    }

    package { ['perl-Catalyst-Devel', 'perl-CPAN']:
        ensure  => latest,
    }
}

node 'server.fxhistoricaldata.com' inherits 'default' {
   class { 'site':
        user    => 'joao',
    }

    class { 'fxtrader::datafeed': }
}
