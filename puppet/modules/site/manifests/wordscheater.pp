class site::wordscheater (
    $base_path,
    $user,
    $group
) {

include apache

file { "$base_path/wordscheater.com":
    ensure      => directory,
    owner       => $user,
    group       => $group,
    mode        => 0755,
}

file { "$base_path/wordscheater.com/web":
    ensure      => directory,
    owner       => $user,
    group       => $group,
    mode        => 0755,
    require     => File["$base_path/wordscheater.com"],
}

file { "$base_path/wordscheater.com/cgi-bin":
    ensure      => directory,
    owner       => "joao",
    group       => "joao",
    mode        => 0755,
    require     => File["$base_path/wordscheater.com"],
}

apache::vhost { 'www.wordscheater.com':
    priority        => '10',
    docroot         => "$base_path/wordscheater.com/web",
    scriptroot      => "$base_path/wordscheater.com/cgi-bin/",
    port            => '80',
    serveraliases   => ['wordscheater.com'],
    require         => [ File["$base_path/wordscheater.com/web"],File["$base_path/wordscheater.com/cgi-bin"], Package['perl-Games-Word'], Package['perl-CGI'], Package['perl-JSON'] ],
}

}
