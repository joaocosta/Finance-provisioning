class fxtrader::test {

    file { "/tmp/testdata.tar":
      source => "puppet:///modules/fxtrader/testdata.tar",
      ensure => "present",
    }

    exec {"db_schema":
      require => Class['fxtrader'],
      command => "/usr/bin/createDBSchema.pl > /tmp/db_schema.sql",
      logoutput => "on_failure",
    }

    exec { "setup_db_tables":
      unless => "/usr/bin/mysql -ufxcm -e 'select count(1) from EURUSD_86400' fxcm",
      require => [Exec["db_schema"]],
      command => "/usr/bin/mysql -uroot fxcm < /tmp/db_schema.sql",
      logoutput => "on_failure",
    }

    exec { "load_test_data":
      require => [File["/tmp/testdata.tar"], Exec["setup_db_tables"]],
      command => "/opt/src/Finance-HostedTrader/t/data/loadTestData.sh /tmp", #TODO, no guarantee the script is in this location
      logoutput => "on_failure",
    }

}
