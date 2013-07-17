class rvm::passenger::apache::ubuntu::post(
  $ruby_version,
  $version,
  $gempath,
  $binpath,
  $rvm_prefix         = '/usr/local/',
  $compiled_module_fn = 'ext/apache2/mod_passenger.so',
  $mininstances       = '1',
  $maxpoolsize        = '6',
  $poolidletime       = '300',
  $maxinstancesperapp = '0',
  $spawnmethod        = 'smart-lv2',
) {

  exec {
    'passenger-install-apache2-module':
      command   => "${binpath}rvm ${ruby_version} exec passenger-install-apache2-module -a",
      creates   => "${gempath}/passenger-${version}/${compiled_module_fn}",
      logoutput => 'on_failure',
      require   => [Rvm_gem['passenger'], Package['apache2', 'build-essential', 'apache2-prefork-dev',
                                                  'libapr-dev', 'libaprutil-dev', 'libcurl4-openssl-dev']],
  }

  file {
    '/etc/apache2/mods-available/passenger.load':
      ensure  => file,
      content => template('rvm/passenger-apache.load.erb'),
      require => Exec['passenger-install-apache2-module'];

    '/etc/apache2/mods-available/passenger.conf':
      ensure  => file,
      content => template('rvm/passenger-apache.conf.erb'),
      require => Exec['passenger-install-apache2-module'];

    '/etc/apache2/mods-enabled/passenger.load':
      ensure  => 'link',
      target  => '../mods-available/passenger.load',
      require => File['/etc/apache2/mods-available/passenger.load'];

    '/etc/apache2/mods-enabled/passenger.conf':
      ensure  => 'link',
      target  => '../mods-available/passenger.conf',
      require => File['/etc/apache2/mods-available/passenger.conf'];
  }

  # Add Apache restart hooks
  if defined(Service['apache']) {
    File['/etc/apache2/mods-available/passenger.load'] ~> Service['apache']
    File['/etc/apache2/mods-available/passenger.conf'] ~> Service['apache']
    File['/etc/apache2/mods-enabled/passenger.load']   ~> Service['apache']
    File['/etc/apache2/mods-enabled/passenger.conf']   ~> Service['apache']
  }
  if defined(Service['apache2']) {
    File['/etc/apache2/mods-available/passenger.load'] ~> Service['apache2']
    File['/etc/apache2/mods-available/passenger.conf'] ~> Service['apache2']
    File['/etc/apache2/mods-enabled/passenger.load']   ~> Service['apache2']
    File['/etc/apache2/mods-enabled/passenger.conf']   ~> Service['apache2']
  }
  if defined(Service['httpd']) {
    File['/etc/apache2/mods-available/passenger.load'] ~> Service['httpd']
    File['/etc/apache2/mods-available/passenger.conf'] ~> Service['httpd']
    File['/etc/apache2/mods-enabled/passenger.load']   ~> Service['httpd']
    File['/etc/apache2/mods-enabled/passenger.conf']   ~> Service['httpd']
  }
}
