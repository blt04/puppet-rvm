class rvm::dependencies {
  case $::operatingsystem {
    FreeBSD: { require rvm::dependencies::freebsd }
    Ubuntu,Debian: { require rvm::dependencies::ubuntu }
    CentOS,RedHat: { require rvm::dependencies::centos }
    OracleLinux,RedHat: { require rvm::dependencies::oraclelinux }
  }
}
