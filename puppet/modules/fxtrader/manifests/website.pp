class fxtrader::website {

class { 'apache':
    ip      =>  '0.0.0.0',
}

package { 'perl-Finance-HostedTrader-UI':
    ensure  => latest,
    notify  => Service['httpd'],
}

class {'apache::mod::perl': }

file { '/home/joao/download':
    ensure  => directory,
    owner   => 'joao',
    group   => 'joao',
    mode    => '0755',
    require => User['joao'],
}

apache::vhost { 'www.fxhistoricaldata.com':
    priority        => '10',
    directories     => [
        {   path    =>  '/', provider   => 'location',  sethandler  => 'modperl',   perlresponsehandler => 'Finance::HostedTrader::UI' },

    ],
    docroot         => '/none', # docroot isn't actually used in the custom template, but the puppet module requires a docroot parameter
    ip              => '0.0.0.0',
    port            => '80',
    override        => 'All',
    serveraliases   => ['fxhistoricaldata.com'],
    require         => [ Package['perl-Finance-HostedTrader-UI'], Class['apache::mod::perl'], Class['fxtrader'] ],
}

}
