class fxtrader {
include mysql
include zonalivre_repo::client

Exec {
    path => ['/usr/bin'],
}

class { 'mysql::server':
}

mysql::db { 'fxcm':
    user     => 'fxcm',
    password => 'fxcm',
    host     => 'localhost',
    grant    => ['all'],
    require  => File['/root/.my.cnf'],
}

package { 'perl-Finance-HostedTrader':
    ensure  => latest,
    require => [ Class['zonalivre_repo::client'], File['/etc/fxtrader/fx.yml'] ],
}

package { 'libmysqludf_ta':
    ensure  => latest,
    require => [ Class['zonalivre_repo::client'], ],
}

exec { 'setup libmysqludf_ta':
    command => 'mysql -uroot < /usr/share/libmysqludf_ta/db_install_lib_mysqludf_ta',
    unless  => "mysql -uroot -e 'SELECT ta_ema(A,1) FROM (select 1.0 AS A) AS T'",
    require => [ Package['libmysqludf_ta'], Class['mysql::server'], Class['mysql'] ],
}

mysql::db { 'fx':
    user     => 'fxhistor',
    password => 'fxhistor',
    host     => 'localhost',
    grant    => ['all'],
    require  => File['/root/.my.cnf'],
}

file { "/etc/fxtrader":
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0755',
}

file { "/etc/fxtrader/fx.yml":
    source  => 'puppet:///modules/fxtrader/etc/fxtrader/fx.yml',
    owner   => root,
    group   => root,
    mode    => '0644',
    require => File['/etc/fxtrader'],
}

file { "/etc/fxtrader/fxtrader.log.conf":
    source  => 'puppet:///modules/fxtrader/etc/fxtrader/fxtrader.log.conf',
    owner   => root,
    group   => root,
    mode    => '0666',
    require => File["/etc/fxtrader"],
}

}
