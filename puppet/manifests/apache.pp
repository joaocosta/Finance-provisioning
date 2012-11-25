include users

realize Users::Mkuser["joao"]

Exec { path => [ '/usr/bin' ] }

package { 'selinux-policy-targeted':
    ensure  => absent,
}

package { 'selinux-policy':
    ensure  => absent,
    require => Package['selinux-policy-targeted'],
}

file { "/etc/localtime":
    ensure  => link,
    target  => "/usr/share/zoneinfo/UTC",
}

file { '/home/joao/sites':
    ensure      => directory,
    owner       => 'joao',
    group       => 'joao',
    mode        => 0755,
    require     => User['joao'],
}

class {'zonalivre_repo':
    base_path   => '/home/joao/rpmbuild',
    user        => 'joao',
    group       => 'joao',
}

class {'zonalivre_repo::client': }

class {'site::wordscheater':
    base_path   => '/home/joao/sites',
    user        => 'joao',
    group       => 'joao',
    require     => [ File['/home/joao/sites'], Class['zonalivre_repo::client'] ],
}

class {'site::zonalivre':
    base_path   => '/home/joao/sites',
    user        => 'joao',
    group       => 'joao',
    require     => File['/home/joao/sites'],
}

class { 'fxtrader': }
class { 'fxtrader::website': }
