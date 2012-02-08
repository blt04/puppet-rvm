class rvm::passenger::gem($ruby_version, $version) {
  rvm_gem {
    "passenger":
      ensure       => $version,
      ruby_version => $ruby_version,
      require      => Rvm_system_ruby["${ruby_version}"],
  }
  if $selinux == 'true' {
    exec { 'passenger-contexts':
      command     => "/sbin/restorecon -R $rvm::system::rvmpath",
      refreshonly => true,
      subscribe   => Rvm_gem['passenger'],
    }
  }
}
