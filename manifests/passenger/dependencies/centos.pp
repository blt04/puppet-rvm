# Package dependencies for Passenger on RedHat
class rvm::passenger::dependencies::centos {
  ensure_packages(['libcurl-devel'])
}
