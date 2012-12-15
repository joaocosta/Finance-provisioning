class fxtrader::test {

    file { '/tmp/testdata.tar':
      source => 'puppet:///modules/fxtrader/testdata.tar',
      ensure => 'present',
    }

    exec { 'load_test_data':
      require => [File['/tmp/testdata.tar'], Class['fxtrader']],
      command => '/opt/src/Finance-HostedTrader/t/data/loadTestData.sh /tmp', #TODO, no guarantee the script is in this location
      logoutput => 'on_failure',
    }

}
