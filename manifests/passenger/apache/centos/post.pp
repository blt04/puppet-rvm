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

  exec { 'passenger-install-apache2-module':
    command   => "$rvmpath/bin/rvm $ruby_version exec passenger-install-apache2-module -a",
    creates   => "${gempath}/passenger-${version}/ext/apache2/mod_passenger.so",
    logoutput => 'on_failure',
    require   => [Rvm_gem['passenger'], Package['httpd','httpd-devel','mod_ssl']];
  }

  if $selinux == 'true' {
    exec { 'passenger-contexts':
      command     => "/sbin/restorecon -R $rvmpath",
      refreshonly => true,
      subscribe   => Exec['passenger-install-apache2-module'],
      before      => File['/etc/httpd/conf.d/passenger.conf'],
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
