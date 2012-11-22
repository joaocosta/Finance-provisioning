include apache
include mysql
include users
include zonalivre_repo

realize Users::Mkuser["joao"]

class { 'mysql::server':
}

file { "/etc/localtime":
    ensure  => link,
    target  => "/usr/share/zoneinfo/UTC",
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

package { ['perl-CGI', 'perl-JSON', 'perl-Games-Word']:
    ensure  => latest,
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
}

file { "/home/joao/sites/fxhistoricaldata.com":
    ensure      => directory,
    owner       => "joao",
    group       => "joao",
    mode        => 0755,
    require     => File["/home/joao/sites"],
}

file { "/home/joao/sites/fxhistoricaldata.com/web":
    ensure      => directory,
    owner       => "joao",
    group       => "joao",
    mode        => 0755,
    require     => File["/home/joao/sites/fxhistoricaldata.com"],
}

package { ['perl-Finance-HostedTrader', 'perl-Catalyst-Runtime']:
    ensure      => latest,
}

apache::vhost { 'www.fxhistoricaldata.com':
    priority        => '10',
    docroot         => '/home/joao/sites/fxhistoricaldata.com/web',
    port            => '80',
    serveraliases   => ['fxhistoricaldata.com'],
    require         => [ File["/home/joao/rpmbuild"] ],
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
