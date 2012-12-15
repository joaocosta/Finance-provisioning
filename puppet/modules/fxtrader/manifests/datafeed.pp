class fxtrader::datafeed {
    file { "/etc/cron.d/forexite_download_data":
        source  => 'puppet:///modules/fxtrader/etc/cron.d/forexite_download_data',
        owner   => root,
        group   => root,
        mode    => '0644',
        require => Class['fxtrader'],
    }

    file { "/etc/cron.d/fxcm_download_data":
        source  => 'puppet:///modules/fxtrader/etc/cron.d/fxcm_download_data',
        owner   => root,
        group   => root,
        mode    => '0644',
        require => Class['fxtrader'],
    }
}
