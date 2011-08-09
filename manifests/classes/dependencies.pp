class rvm::dependencies {
  case $operatingsystem {
    Ubuntu: { require rvm::dependencies::ubuntu }
    CentOS: { require rvm::dependencies::centos }
  }
}
