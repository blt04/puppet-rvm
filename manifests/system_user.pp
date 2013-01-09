define rvm::system_user () {

  $username = $title
  $group = $::operatingsystem ? {
    default => 'rvm',
  }

  if ! defined(User[$username]) {
    user { $username:
      ensure => present;
    }
  }

  if ! defined(Group[$group]) {
    group { $group:
      ensure => present;
    }
  }

  case $operatingsystem {
    freebsd: { $umod => "pw usermod $username -G $group" }
    default: {  $umod => "/usr/sbin/usermod -a -G $group $username" }
  }
  
  
  exec { $umod:
    unless  => "/bin/cat /etc/group | grep $group | grep $username",
    require => [User[$username], Group[$group]];
  }
}
