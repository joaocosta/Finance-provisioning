class fxtrader {
include mysql

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
    require  => File['/root/.my.cnf'], #This resource is declared in the mysql module. There's a bug there because it tries to use "/root/.my.cnf" before it's been deployed, so i force the dependency here to workaround that. Raised http://projects.puppetlabs.com/issues/17802, someone there proposed a different workaround using stages. Note that just requiring Class['mysql::server'] is not enough to work around this.
}

mysql::db { 'fx':
    user     => 'fxhistor',
    password => 'fxhistor',
    host     => 'localhost',
    grant    => ['all'],
    require  => File['/root/.my.cnf'],
}

exec {"fetch_db_schema":
    require     => Package['perl-Finance-HostedTrader'],
    command     => "/usr/bin/fx-create-db-schema.pl > /tmp/db_schema.sql",
    logoutput   => "on_failure",
}

exec { "setup_db_tables":
    unless      => "/usr/bin/mysql -ufxcm -pfxcm -e 'select count(1) from EURUSD_86400' fxcm",
    require     => [Exec["fetch_db_schema"], Database['fxcm']],
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
        require => [ Package['libmysqludf_ta'], Class['mysql::server'], Class['mysql'] ],
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
