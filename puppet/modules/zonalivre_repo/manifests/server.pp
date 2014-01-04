class zonalivre_repo::server(
    $base_path,
    $user,
    $group,
) {

package { 'createrepo':
    ensure      => latest,
}

file { $base_path:
    ensure      => directory,
    owner       => $user,
    group       => $group,
    mode        => 0755,
    require     => [ User[$user], Group[$group] ],
}

apache::vhost { 'packages.zonalivre.org':
    priority    => '10',
    docroot     => $base_path,
    ip          => '0.0.0.0',
    port        => '80',
    require     => [ File[$base_path] ],
}

} # class zonalivre_repo::server
