
class rvm::passenger($ruby_version, $version, $rvm_prefix) {
    rvm_gem {
        'passenger':
            ruby_version => $ruby_version,
            ensure => $version,
            rvm_prefix => $rvm_prefix,
            require => Rvm_system_ruby[$ruby_version];
    }
}


class rvm::passenger::apache(
    $ruby_version,
    $version,
    $rvm_prefix = '/usr/local/',
    $mininstances = '1',
    $maxpoolsize = '6',
    $poolidletime = '300',
    $maxinstancesperapp = '0',
    $spawnmethod = 'smart-lv2'
) {

    # TODO: How to inherit this from above?
    class { 'rvm::passenger': ruby_version => $ruby_version, version => $version, rvm_prefix => $rvm_prefix }
    include apache

    # TODO: How can we get the gempath automatically using the ruby version
    # Can we read the output of a command into a variable?
    # e.g. $gempath = `usr/local/bin/rvm ${ruby_version} exec rvm gemdir`
    $gempath = "${rvm_prefix}rvm/gems/${ruby_version}/gems"
    $binpath = "${rvm_prefix}rvm/bin/"


    # Dependencies
    if ! defined(Package['build-essential'])      { package { build-essential:      ensure => installed } }
    if ! defined(Package['apache2-prefork-dev'])  { package { apache2-prefork-dev:  ensure => installed } }
    if ! defined(Package['libapr1-dev'])          { package { libapr1-dev:          ensure => installed, alias => 'libapr-dev' } }
    if ! defined(Package['libaprutil1-dev'])      { package { libaprutil1-dev:      ensure => installed, alias => 'libaprutil-dev' } }
    if ! defined(Package['libcurl4-openssl-dev']) { package { libcurl4-openssl-dev: ensure => installed } }

    exec {
        'passenger-install-apache2-module':
            command => "${binpath}rvm ${ruby_version} exec passenger-install-apache2-module -a",
            creates => "${gempath}/passenger-${version}/ext/apache2/mod_passenger.so",
            logoutput => 'on_failure',
            require => [Rvm_gem['passenger'], Package[
                'apache2',
                'build-essential',
                'apache2-prefork-dev',
                'libapr-dev',
                'libaprutil-dev',
                'libcurl4-openssl-dev'
            ]];
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

class rvm::passenger::apache::disable {

    file {
        '/etc/apache2/mods-enabled/passenger.load':
            ensure => 'absent';
        '/etc/apache2/mods-enabled/passenger.conf':
            ensure => 'absent';
    }

    # Add Apache restart hooks
    if defined(Service['apache']) {
      File['/etc/apache2/mods-enabled/passenger.load']   ~> Service['apache']
      File['/etc/apache2/mods-enabled/passenger.conf']   ~> Service['apache']
    }
    if defined(Service['apache2']) {
      File['/etc/apache2/mods-enabled/passenger.load']   ~> Service['apache2']
      File['/etc/apache2/mods-enabled/passenger.conf']   ~> Service['apache2']
    }
    if defined(Service['httpd']) {
      File['/etc/apache2/mods-enabled/passenger.load']   ~> Service['httpd']
      File['/etc/apache2/mods-enabled/passenger.conf']   ~> Service['httpd']
    }
}
