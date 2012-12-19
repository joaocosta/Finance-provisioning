
define zonalivre_repo::client(
    $location   = '/etc/yum.repos.d/zonalivre.repo',
    $url        = 'http://packages.zonalivre.org/RPMS/noarch/',
    $owner      = 'root',
    $group      = 'root',
) {
    file { $location:
        ensure  => present,
        owner   => $owner,
        group   => $group,
        mode    => 644,
        content => template('zonalivre_repo/zonalivre.repo.erb'),
    }
}
