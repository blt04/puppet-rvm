define rvm::system_user () {

  $group = $::operatingsystem ? {
    default => 'rvm',
  }

  ensure_resource('user', $name, {'ensure' => 'present' })
  ensure_resource('group', $group, {'ensure' => 'present' })

  exec { "/usr/sbin/usermod -a -G ${group} ${name}":
    unless  => "/bin/cat /etc/group | grep ${group} | grep ${name}",
    require => [User[$name], Group[$group]];
  }
}
