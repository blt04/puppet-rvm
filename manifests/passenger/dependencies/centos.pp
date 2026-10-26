# Package dependencies for Passenger on RedHat
class rvm::passenger::dependencies::centos {
  stdlib::ensure_packages(['libcurl-devel'])
}
