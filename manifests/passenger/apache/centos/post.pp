class rvm::passenger::apache::centos::post(
  $ruby_version,
  $version,
  $mininstances = '1',
  $maxpoolsize = '6',
  $poolidletime = '300',
  $maxinstancesperapp = '0',
  $spawnmethod = 'smart-lv2',
  $rvmpath = $rvm::system::rvmpath,
  $gempath
) {

  $passdir = "${gempath}/passenger-${version}"

  exec { 'passenger-install-apache2-module':
    command   => "$rvm_binary ${ruby_version} exec passenger-install-apache2-module -a",
    creates   => "$passdir/ext/apache2/mod_passenger.so",
    logoutput => 'on_failure',
    require   => [Rvm_gem['passenger'], Package['httpd','httpd-devel','mod_ssl']];
  }

  # Fix selinux file contexts
  # On RHEL6 with a current policy, these are automatic when passenger is
  # installed in the system ruby gems directory, but the nonstandard rvm
  # location means they don't get set correctly by the default policy
  if $selinux == 'true' {
    file { "$rvmpath/wrappers":
      ensure  => directory,
      recurse => true,
      group   => 'rvm',
      mode    => 0755,
      seltype => 'bin_t',
      before  => File['/etc/httpd/conf.d/passenger.conf'],
    }
    file { "$passdir/ext/apache2/mod_passenger.so":
      group   => 'rvm',
      mode    => 0755,
      seltype => 'lib_t',
      require => Exec['passenger-install-apache2-module'],
      before  => File['/etc/httpd/conf.d/passenger.conf'],
    }
    file { [
      "$passdir/agents/PassengerLoggingAgent",
      "$passdir/agents/PassengerWatchdog",
      "$passdir/agents/apache2/PassengerHelperAgent"
    ]:
      group   => 'rvm',
      mode    => 0755,
      seltype => 'passenger_exec_t',
      require => Exec['passenger-install-apache2-module'],
      before  => File['/etc/httpd/conf.d/passenger.conf'],
    }
  }

  file { '/etc/httpd/conf.d/passenger.conf':
    content => template('rvm/passenger-apache-centos.conf.erb'),
    require => Exec['passenger-install-apache2-module'];
  }

  if defined(Service['httpd']) {
    File['/etc/httpd/conf.d/passenger.conf'] ~> Service['httpd']
  }
}
