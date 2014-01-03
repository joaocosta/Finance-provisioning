class fxtrader {

Exec {
    path => ['/usr/bin'],
}

class { 'mysql::server':
    package_name    =>  'mariadb-server',
    service_name    =>  'mariadb',
}

class { 'mysql::client':
    package_name    =>  'mariadb',
}

mysql::db { 'fxcm':
    user     => 'fxcm',
    password => 'fxcm',
    host     => 'localhost',
    grant    => ['all'],
}

mysql::db { 'fx':
    user     => 'fxhistor',
    password => 'fxhistor',
    host     => 'localhost',
    grant    => ['all'],
}

exec {"fetch_db_schema":
    require     => Package['perl-Finance-HostedTrader'],
    command     => "/usr/bin/fx-create-db-schema.pl > /tmp/db_schema.sql",
    logoutput   => "on_failure",
    creates     => "/tmp/db_schema.sql",
}

exec { "setup_db_tables":
    unless      => "/usr/bin/mysql -ufxcm -pfxcm -e 'select count(1) from EURUSD_86400' fxcm",
    require     => [Exec["fetch_db_schema"], Mysql_database['fxcm']],
    command     => "/usr/bin/mysql -uroot fxcm < /tmp/db_schema.sql",
    logoutput   => "on_failure",
}

package { 'perl-Finance-HostedTrader':
    ensure  => latest,
    require => [ File['/etc/fxtrader/fx.yml'] ],
}

package { 'libmysqludf_ta':
    ensure  => latest,
    notify  => Service['mysqld'],
}

define setup_libmysqludf_ta {
    exec { "setup libmysqludf_ta_${name}":
        command => "mysql -uroot < /usr/share/libmysqludf_ta/lib_mysqludf_ta_${name}_up",
        unless  => "test $(mysql -N -uroot -e 'select count(1) from mysql.func where name = \"ta_${name}\"') -eq 1",
        require => [ Package['libmysqludf_ta'], Class['mysql::server'], Class['mysql::client'] ],
    }
}

setup_libmysqludf_ta { "ema": }
setup_libmysqludf_ta { "max": }
setup_libmysqludf_ta { "min": }
setup_libmysqludf_ta { "previous": }
setup_libmysqludf_ta { "rsi": }
setup_libmysqludf_ta { "sma": }
setup_libmysqludf_ta { "stddevp": }
setup_libmysqludf_ta { "sum": }
setup_libmysqludf_ta { "tr": }

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
