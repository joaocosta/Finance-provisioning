include apache
include users

realize Users::Mkuser["joao"]

file { "/etc/localtime":
    ensure  => link,
    target  => "/usr/share/zoneinfo/UTC",
}

file { "/home/joao/sites/wordscheater.com/web":
    ensure      => directory,
    recursive   => true,
    mode        => 0755,
    require     => User["joao"],
}

apache::vhost { 'www.wordscheater.com':
    priority        => '10',
    docroot         => '/home/joao/sites/wordscheater.com/web',
    port            => '80',
    serveraliases   => ['wordscheater.com'],
    require         => File["/home/joao/sites/wordscheater.com/web"],
}
