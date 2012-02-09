class rvm::dependencies {
  # Precreate the rvm group, otherwise the git installer fails to create it
  # as a system group
  if ! defined(Group['rvm']) {
    group { 'rvm':
      ensure => present,
      system => true,
    }
  }

  case $operatingsystem {
    Ubuntu,Debian: { require rvm::dependencies::ubuntu }
    CentOS,RedHat: { require rvm::dependencies::centos }
  }
}
