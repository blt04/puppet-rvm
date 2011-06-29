class rvm::dependencies {
  case $operatingsystem {
    Ubuntu: { include rvm::dependencies::ubuntu }
    CentOS: { include rvm::dependencies::centos }
  }
}
