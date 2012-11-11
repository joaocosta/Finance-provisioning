class rpm-repo (
    $base_dir,
    $owner,
    $group
) {
    package { "['createrepo', 'yum-utils']":
        ensure      => latest,
    }

    file { "$base_dir/RPMS":
        ensure  => present,
        mode    => 755,
        owner   => $owner,
        group   => $group,
    }

    file { "$base_dir/SRPMS":
        ensure  => present,
        mode    => 755,
        owner   => $owner,
        group   => $group,
    }

}
