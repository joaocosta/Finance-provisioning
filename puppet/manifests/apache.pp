include apache
include users

realize Users::Mkuser["joao"]

file { "/etc/localtime":
    ensure  => link,
    target  => "/usr/share/zoneinfo/UTC",
}

/*
apache::vhost { 'www,fxhistoricaldata.com':
    priority        => '10',
    docroot         => '/home/fxhistor/fxhistoricaldata.com/web',
    port            => '80',
    serveraliases   => ['fxhistoricaldata.com'],
}
*/
