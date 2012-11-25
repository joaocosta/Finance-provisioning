include apache
include mysql
include users
include zonalivre_repo

realize Users::Mkuser["joao"]

Exec { path => [ '/usr/bin' ] }

class { 'mysql::server':
}

file { "/etc/localtime":
    ensure  => link,
    target  => "/usr/share/zoneinfo/UTC",
}

package { 'selinux-policy-targeted':
    ensure  => absent,
}

package { 'selinux-policy':
    ensure  => absent,
    require => Package['selinux-policy-targeted'],
}

file { "/home/joao/sites":
    ensure      => directory,
    owner       => "joao",
    group       => "joao",
    mode        => 0755,
    require     => User["joao"],
}

file { "/home/joao/sites/wordscheater.com":
    ensure      => directory,
    owner       => "joao",
    group       => "joao",
    mode        => 0755,
    require     => File["/home/joao/sites"],
}

file { "/home/joao/sites/wordscheater.com/web":
    ensure      => directory,
    owner       => "joao",
    group       => "joao",
    mode        => 0755,
    require     => File["/home/joao/sites/wordscheater.com"],
}

file { "/home/joao/sites/wordscheater.com/cgi-bin":
    ensure      => directory,
    owner       => "joao",
    group       => "joao",
    mode        => 0755,
    require     => File["/home/joao/sites/wordscheater.com"],
}

package { ['perl-CGI', 'perl-JSON',]:
    ensure  => latest,
}

package { 'perl-Games-Word':
    ensure  => latest,
    require => Class['zonalivre_repo'],
}

apache::vhost { 'www.wordscheater.com':
    priority        => '10',
    docroot         => '/home/joao/sites/wordscheater.com/web',
    scriptroot      => '/home/joao/sites/wordscheater.com/cgi-bin/',
    port            => '80',
    serveraliases   => ['wordscheater.com'],
    require         => [ File["/home/joao/sites/wordscheater.com/web"],File["/home/joao/sites/wordscheater.com/cgi-bin"] ],
}

class {'apache::mod::php': }

file { "/home/joao/sites/zonalivre.org":
    ensure      => directory,
    owner       => "joao",
    group       => "joao",
    mode        => 0755,
    require     => File["/home/joao/sites"],
}

file { "/home/joao/sites/zonalivre.org/web":
    ensure      => directory,
    owner       => "joao",
    group       => "joao",
    mode        => 0755,
    require     => File["/home/joao/sites/zonalivre.org"],
}

apache::vhost { 'www.zonalivre.org':
    priority        => '10',
    docroot         => '/home/joao/sites/zonalivre.org/web',
    port            => '80',
    override        => 'All',
    serveraliases   => ['zonalivre.org'],
    require         => [ File["/home/joao/sites/wordscheater.com/web"] ],
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
