# Package dependencies for Passenger on Ubuntu
class rvm::passenger::dependencies::ubuntu {
  stdlib::ensure_packages(['curl','libcurl4-gnutls-dev'])
}
