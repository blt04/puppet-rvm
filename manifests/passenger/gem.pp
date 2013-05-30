class rvm::passenger::gem($ruby_version, $version) {
  rvm_gem {
    "passenger":
      ensure       => $version,
      require => Rvm_system_ruby["${ruby_version}"],
      ruby_version => $ruby_version;
  }
}
