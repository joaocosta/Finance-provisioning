include apache
include users

realize Users::Mkuser["joao"]

package { ['mysql-server', 'mysql', 'php-mysql']:
    ensure  => latest,
}

service { 'mysqld':
    ensure  => running,
    require => Package['mysql-server'],
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
    serveraliases   => ['zonalivre.org'],
    require         => [ File["/home/joao/sites/wordscheater.com/web"] ],
}


