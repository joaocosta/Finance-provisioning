# Class: zonalivre_repo
#
# This module manages the zonalivre.org rpm packages repo
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
class zonalivre_repo {

    file { '/etc/yum.repos.d/zonalivre.repo':
        ensure  => present,
        owner   => root,
        group   => root,
        mode    => 644,
        source  => 'puppet:///modules/zonalivre_repo/zonalivre.repo',
    }
} # class zonalivre_repo
