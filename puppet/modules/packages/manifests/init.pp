class packages {

include zonalivre_repo

package { 'selinux-policy-targeted':
    ensure  => absent,
}

package { 'selinux-policy':
    ensure  => absent,
    require => Package['selinux-policy-targeted'],
}

package { ['perl-CGI', 'perl-JSON',]:
    ensure  => latest,
}

package { 'perl-Games-Word':
    ensure  => latest,
    require => Class['zonalivre_repo'],
}
}
