class zonalivre_repo(
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
    port        => '80',
    require     => [ File[$base_path] ],
}

} # class zonalivre_repo
