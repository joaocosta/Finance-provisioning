# Class: users
#
# This module manages users, groups
#
# Parameters: $perl_version - version of the Perl Debian package to be installed, either a version string or 'latest'
#
# Actions: 
#
# Requires:
#
# Sample Usage:
#
# 
#
# [Remember: No empty lines between comments and class definition]
class users {

    define sudonopasswd( ) {
        augeas { "sudo${name}":
            context => "/files/etc/sudoers",
            changes => [
                "set spec[user = '${name}']/user ${name}",
                "set spec[user = '${name}']/host_group/host ALL",
                "set spec[user = '${name}']/host_group/command ALL",
                "set spec[user = '${name}']/host_group/command/runas_user ALL",
                "set spec[user = '${name}']/host_group/command/tag NOPASSWD",
            ],
        }
    }

    # This definition is a convenience wrapper around 
    # Puppet's existing user/goup/authorized_key resources.
    define mkuser (
    $uid,
    $gid = $uid,
    $group = $name,
    $shell = "/bin/bash",
    $home = "/home/$name",
    $managehome = true,
    $dotssh = "ensure",
    $comment = "created via puppet",
    $groups = [ ],
    $password = undef,
    $mode = "0700",
    $authorized_key_ensure = "absent",
    $authorized_key_type = "ssh-rsa",
    $authorized_key_string = undef,
    $sudonopasswd = false
    ) {

        # create user
        user { "$name":
            uid        => "$uid",
            gid        => "$gid",
            shell      => "$shell",
            groups     => $groups,
            membership => inclusive,
            password   => $password,
            managehome => "$managehome",
            home       => "$home",
            ensure     => "present",
            comment    => "$comment",
            require    => [ Group["$group"], Group[$groups] ]
        } # user

        group { "$name":
            gid    => "$gid",
            name   => "$group",
            ensure => "present",
        } # group

        ssh_authorized_key { "$name":
            user    => "$name",
            ensure  => $authorized_key_ensure,
            key     => "$authorized_key_string",
            type    => "$authorized_key_type",
            name    => "$name",
            require => User["$name"],
        } # ssh_authorized_keys

        # create home dir
        file { "$home":
            ensure  => directory,
            owner   => $name,
            group   => $name,
            require => User["$name"],
            recurse => true,
            source  => ["puppet:///modules/users/${name}", "puppet:///modules/users/skel"],
        } # file

        # create ~/.ssh
        case $dotssh {
            "ensure","true": {
                file { "$home/.ssh":
                    ensure  => directory,
                    mode    => "700",
                    owner   => $name,
                    group   => $name,
                    require => User["$name"],
                } # file
            } # 'ensure' or 'true'
        } # case

        if $sudonopasswd {
            sudonopasswd { $name: }
        }
    } # define mkuser

    # Definition: mkgroup
    #
    # mkgroup creates a group that can be realized in the module that employs it
    #
    # Parameters:
    #   $gid        - GID of user, defaults to UID
    #
    # Actions: creates a group
    #
    # Requires:
    #   $gid
    #
    # Sample Usage:
    #   # create systems group and realize it
    #   @mkgroup { "systems":
    #       gid => "30000",
    #   } # @mkgroup
    #
    #   realize Generic::Mkgroup[systems]
    #
    define mkgroup ($gid) {
        group { "$name":
            ensure => present,
            gid    => "$gid",
            name   => "$name",   
        } # group
    } # define mkgroup


    $users_to_remove = []

    # this is all listed here and realized within the module with 'realize Generic::Mkuser[username]'
    # it is here and not in the modules, so that we have one place to list all the uid/gid's
    # to avoid using the same numbers
    #
    # please keep sorted by UID
    @mkuser {
 	"joao":
            uid        => "40001",
            gid        => "40001",
            managehome => "true",
            comment    => "Joao Costa",
            authorized_key_ensure => present,
            authorized_key_type   => "ssh-rsa",
            authorized_key_string => "AAAAB3NzaC1yc2EAAAADAQABAAABAQC6hE75Ox6wDfXVJzXeKdyUBO4o19TtGxboJTI2vR3CE9ZJbODIxSr+tfMZcwmuSF892PiahhVzAA2wJ6LdMtFH6FUIGvjU0i7jIo/x+TmvheH46N9qllo2C2ZlxL/HbpRYIyqEntUYcBQzYBvUwnzoDFgS1GhG4LalYp0U9zlHGOA/Wk7qBjH8Ca1mtPSnxudsb/NwERIjfLbvdX9Fc+vkx6fs3ykJv+p8lPEZkw3kcVAfuyhnXzE7kprSHDuOuQo0FDvCTjy9ISxZPvExKT7bD7vQRlrx9PLzYSWI7/evonWHR8c/jPS8U56ii8YH/rtC/iqo4LiwKFxoxaDdS2wD",
            sudonopasswd => true,
            ;
       } # @mkuser

    rmuser { $users_to_remove: }

    define rmuser (
    ) {
        user { "$name":
            ensure     => absent,
        } # user

        group { "$name":
            ensure => absent,
        } # group

        file { "/home/$name":
            ensure  => absent,
            recurse => true,
            force   => true,
        } # file

        augeas { "sudorm${name}":
            context => "/files/etc/sudoers",
            changes => [
                "rm *[user = '${name}']",
            ],
            require => Package["libaugeas-ruby"],
        }
    } # define rmuser



    # this is all listed here and realized within the module with 'realize Generic::Mkgroup[groupname]'
    # it is here and not in the modules, so that we have one place to list all the uid/gid's
    # to avoid using the same numbers
    #
    # please keep sorted by GID
    @mkgroup {
        "dev":
            gid => "30002";
    } # @mkgroup

} # class generic