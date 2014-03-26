class rvm::passenger::apache::centos::post(
  $ruby_version,
  $version,
  $rvm_prefix = '/usr/local/',
  $mininstances = '1',
  $maxpoolsize = '6',
  $poolidletime = '300',
  $maxinstancesperapp = '0',
  $spawnmethod = 'smart-lv2',
  $gempath,
  $binpath
) {

  if $version > '4.0.0' {
    $install_out_directory = 'buildout'
  } elsif $version > '3.9.0' {
    $install_out_directory = 'libout'
  }  else {
    $install_out_directory = 'ext'
  }

  $install_creates = "${rvm::passenger::apache::gempath}/passenger-${rvm::passenger::apache::version}/${install_out_directory}/apache2/mod_passenger.so"

  exec {
    'passenger-install-apache2-module':
      command   => "${rvm::passenger::apache::binpath}rvm ${rvm::passenger::apache::ruby_version} exec passenger-install-apache2-module -a",
      creates   => $install_creates,
      logoutput => 'on_failure',
      require   => [Rvm_gem['passenger'], Package['httpd','httpd-devel','mod_ssl']];
  }

  file {
    '/etc/httpd/conf.d/passenger.conf':
      ensure  => file,
      content => template('rvm/passenger-apache-centos.conf.erb'),
      require => Exec['passenger-install-apache2-module'];
  }
}
