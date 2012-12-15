class site (
    $user,
){
    file { "/home/$user/sites":
        ensure      => directory,
        owner       => $user,
        group       => $user,
        mode        => 0755,
        require     => User[$user],
    }

    class {'site::wordscheater':
        base_path   => "/home/$user/sites",
        user        => $user,
        group       => $user,
        require     => [ File["/home/$user/sites"], Class['zonalivre_repo::client'] ],
    }

    class { 'site::zonalivre':
        base_path   => "/home/$user/sites",
        user        => $user,
        group       => $user,
        require     => File["/home/$user/sites"],
    }
}
