class fxtrader {
include mysql

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
    require => [ Class['zonalivre_repo::client'], File['/etc/fx.yml'] ],
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

file { "/etc/fx.yml":
    source  => 'puppet:///modules/fxtrader/etc/fx.yml',
    owner   => root,
    group   => root,
    mode    => '0644'
}

if !$::sandbox {
file { "/etc/cron.d/forexite_download_data":
    source  => 'puppet:///modules/fxtrader/etc/cron.d/forexite_download_data',
    owner   => root,
    group   => root,
    mode    => '0644'
}

file { "/etc/cron.d/fxcm_download_data":
    source  => 'puppet:///modules/fxtrader/etc/cron.d/fxcm_download_data',
    owner   => root,
    group   => root,
    mode    => '0644'
}
}

}
