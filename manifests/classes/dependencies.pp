class rvm::dependencies {
  case $operatingsystem {
    Ubuntu: { require rvm::dependencies::ubuntu }
    CentOS,RedHat: { require rvm::dependencies::centos }
  }
}
