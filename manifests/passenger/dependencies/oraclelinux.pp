# Package dependencies for Passenger on Oracle Linux
class rvm::passenger::dependencies::oraclelinux {
  stdlib::ensure_packages(['libcurl-devel'])
}
