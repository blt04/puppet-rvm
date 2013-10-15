class rvm::passenger::apache::ubuntu::pre {

  # Dependencies
  ensure_packages(['apache2','build-essential','apache2-prefork-dev','libapr1-dev','libaprutil1-dev','libcurl4-openssl-dev'])
}
