Exec { path => [ '/usr/bin' ] }

stage { 'init':
    before  => Stage['main'],
}

include users
realize Users::Mkuser['joao']

#exec { 'mount_src':
#    command => 'mount -t vboxsf -o uid=`id -u joao`,gid=`id -g joao` v-data /opt/src',
#    require => [ User['joao'], Group['joao'] ],
#}

#mount { 'opt/src':
#    atboot  => 'false',
#    device  => 'v-data',
#    ensure  => 'mounted',
#    fstype  => 'vboxsf',
#    remounts=> 'true',
#    options => 'defaults',
#}

file { '/etc/localtime':
    ensure  => link,
    target  => '/usr/share/zoneinfo/UTC',
}

class { 'zonalivre_repo::client':
    stage   => 'init',
}

package { 'selinux-policy-targeted':
    ensure  => absent,
}

package { 'selinux-policy':
    ensure  => absent,
    require => Package['selinux-policy-targeted'],
}

node default {
    class { 'zonalivre_repo::server':
        base_path   => '/home/joao/rpmbuild',
        user        => 'joao',
        group       => 'joao',
    }

    class { 'fxtrader': }
    class { 'fxtrader::test': }
    class { 'fxtrader::website': }

    class { 'buildbox':
        user => 'joao',
    }
}

node 'server.zonalivre.org' inherits 'default' {
    class { 'site':
        user    => 'joao',
    }

    class { 'fxtrader::datafeed': }
}
