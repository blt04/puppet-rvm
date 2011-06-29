class rvm::passenger::apache::ubuntu::post {

  exec {
    'passenger-install-apache2-module':
      command => "${binpath}rvm ${ruby_version} exec passenger-install-apache2-module -a",
      creates => "${gempath}/passenger-${version}/ext/apache2/mod_passenger.so",
      logoutput => 'on_failure',
      require => [Rvm_gem['passenger'], Package['apache2', 'build-essential', 'apache2-prefork-dev',
                                                'libapr-dev', 'libaprutil-dev', 'libcurl4-openssl-dev']],
  }

  file {
    '/etc/apache2/mods-available/passenger.load':
        content => "LoadModule passenger_module ${gempath}/passenger-${version}/ext/apache2/mod_passenger.so",
        ensure => file,
        require => Exec['passenger-install-apache2-module'];
    
    '/etc/apache2/mods-available/passenger.conf':
        content => template('rvm/passenger-apache.conf.erb'),
        ensure => file,
        require => Exec['passenger-install-apache2-module'];
    
    '/etc/apache2/mods-enabled/passenger.load':
        ensure => 'link',
        target => '../mods-available/passenger.load',
        require => File['/etc/apache2/mods-available/passenger.load'];
    
    '/etc/apache2/mods-enabled/passenger.conf':
        ensure => 'link',
        target => '../mods-available/passenger.conf',
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