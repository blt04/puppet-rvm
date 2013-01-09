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
    freeBSD: { $ummod => "pw usermod $username -G $group" }
    default: {  $unmod => "/usr/sbin/usermod -a -G $group $username" }
  }
  
  
  exec { "$ummod":
    unless  => "/bin/cat /etc/group | grep $group | grep $username",
    require => [User[$username], Group[$group]];
  }
}
