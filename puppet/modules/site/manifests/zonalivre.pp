class site::zonalivre (
    $base_path,
    $user,
    $group
) {

include apache

class {'apache::mod::php': }

file { "$base_path/zonalivre.org":
    ensure      => directory,
    owner       => $user,
    group       => $group,
    mode        => 0755,
}

file { "$base_path/zonalivre.org/web":
    ensure      => directory,
    owner       => $user,
    group       => $group,
    mode        => 0755,
    require     => File["$base_path/zonalivre.org"],
}

apache::vhost { 'www.zonalivre.org':
    priority        => '10',
    docroot         => "$base_path/zonalivre.org/web",
    port            => '80',
    override        => 'All',
    serveraliases   => ['zonalivre.org'],
    require         => [ File["$base_path/zonalivre.org/web"] ],
}

}
