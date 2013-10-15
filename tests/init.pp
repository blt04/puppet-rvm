case $::operatingsystem {

  Ubuntu,Debian: {}

  CentOS,RedHat,Fedora,rhel,Amazon,Scientific: {
    class { 'epel':
      before => Class['rvm'],
    }
  }

  OracleLinux: {}

  default: {}
}

class { 'rvm': }
