class rvm::passenger::gem($ruby_version, $version, $rvm_prefix) {
  rvm_gem {
    "passenger":
      ruby_version => $ruby_version,
      ensure => $version,
      rvm_prefix => $rvm_prefix,
  }
}