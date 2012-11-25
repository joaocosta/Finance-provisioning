include apache
include mysql
include users
include packages

realize Users::Mkuser["joao"]

Exec { path => [ '/usr/bin' ] }

class { 'mysql::server':
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

class {'site::wordscheater':
    base_path   => '/home/joao/sites',
    user        => 'joao',
    group       => 'joao',
    require     => File['/home/joao/sites'],
}

class {'site::zonalivre':
    base_path   => '/home/joao/sites',
    user        => 'joao',
    group       => 'joao',
    require     => File['/home/joao/sites'],
}

file { "/home/joao/rpmbuild":
    ensure      => directory,
    owner       => "joao",
    group       => "joao",
    mode        => 0755,
    require     => User["joao"],
}

apache::vhost { 'packages.zonalivre.org':
    priority        => '10',
    docroot         => '/home/joao/rpmbuild',
    port            => '80',
    require         => [ File["/home/joao/rpmbuild"] ],
}

package { ['perl-Finance-FXCM-Simple']:
    ensure  => latest,
    require => Class['zonalivre_repo'],
}

package { 'perl-Finance-HostedTrader':
    ensure  => latest,
    require => [ Class['zonalivre_repo'], File['/etc/fx.yml'] ],
}

package { 'libmysqludf_ta':
    ensure  => latest,
    require => [ Class['zonalivre_repo'], ],
}

package { 'perl-Finance-HostedTrader-UI':
    ensure  => latest,
    require => Class['zonalivre_repo'],
    notify  => Service['httpd'],
}

exec { 'setup libmysqludf_ta':
    command => 'mysql -uroot < /usr/share/libmysqludf_ta/db_install_lib_mysqludf_ta',
    unless  => "mysql -uroot -e 'SELECT ta_ema(A,1) FROM (select 1.0 AS A) AS T'",
    require => [ Package['libmysqludf_ta'], Class['mysql::server'], Class['mysql'] ],
}

class {'apache::mod::perl': }

file { '/home/joao/download':
    ensure  => directory,
    owner   => 'joao',
    group   => 'joao',
    mode    => '0755',
}

apache::vhost { 'www.fxhistoricaldata.com':
    priority        => '10',
    docroot         => '/none', # docroot isn't actually used in the custom template, but the puppet module requires a docroot parameter
    port            => '80',
    override        => 'All',
    serveraliases   => ['fxhistoricaldata.com'],
    template        => 'fx/vhost-fxhistoricaldata.conf.erb',
    require         => [ Package['perl-Finance-HostedTrader-UI'], Class['apache::mod::perl'] ],
}

mysql::db { 'fxcm':
    user     => 'fxcm',
    password => 'fxcm',
    host     => 'localhost',
    grant    => ['all'],
    require  => File['/root/.my.cnf'],
}

mysql::db { 'fx':
    user     => 'fxhistor',
    password => 'fxhistor',
    host     => 'localhost',
    grant    => ['all'],
    require  => File['/root/.my.cnf'],
}

file { "/etc/fx.yml":
    source  => 'puppet:///modules/fx/etc/fx.yml',
    owner   => root,
    group   => root,
    mode    => '0644'
}

file { "/etc/cron.d/forexite_download_data":
    source  => 'puppet:///modules/fx/etc/cron.d/forexite_download_data',
    owner   => root,
    group   => root,
    mode    => '0644'
}

file { "/etc/cron.d/fxcm_download_data":
    source  => 'puppet:///modules/fx/etc/cron.d/fxcm_download_data',
    owner   => root,
    group   => root,
    mode    => '0644'
}
