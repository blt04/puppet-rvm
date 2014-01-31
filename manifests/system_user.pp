define rvm::system_user () {
  include rvm::params

  ensure_resource('user', $name, {'ensure' => 'present' })
  include rvm::group

  exec { "rvm-system-user-${name}":
    command => "/usr/sbin/usermod -a -G ${rvm::params::group} ${name}",
    unless  => "/bin/cat /etc/group | grep ${rvm::params::group} | grep ${name}",
    require => [User[$name], Group[$rvm::params::group]];
  }
}
