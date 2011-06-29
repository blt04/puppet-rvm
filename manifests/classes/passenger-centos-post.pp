class rvm::passenger::apache::centos::post {
  
  exec {
    'passenger-install-apache2-module':
      command => "${binpath}rvm ${ruby_version} exec passenger-install-apache2-module -a",
      creates => "${gempath}/passenger-${version}/ext/apache2/mod_passenger.so",
      logoutput => 'on_failure',
      require => [Rvm_gem['passenger'], Package['httpd','httpd-devel','mod_ssl']];
  }
  
  file {
    '/etc/httpd/conf.d/passenger.conf':
      content => template('rvm/passenger-apache-centos.conf.erb'),
      ensure => file,
      require => Exec['passenger-install-apache2-module'];
  }
  
}