class rvm::system {

  include rvm::dependencies

  file {'install-system-rvm':
    ensure => 'present',
    path => '/root/install-system-rvm',
    owner => 'root', group => 'root', mode => '0774',
    source => 'puppet:///modules/rvm/install-system-rvm';
  }

  exec { 'system-rvm':
    command => '/root/install-system-rvm',
    require => [
      File['install-system-rvm'],
      Package['curl', 'git-core'],
      Class['rvm::dependencies'],
    ],
    creates => '/usr/local/bin/rvm';
  }

}
