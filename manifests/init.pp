class rvm($version=undef, $install_rvm=true) {

  if $install_rvm {
    class { 'rvm::dependencies': }

    class { 'rvm::system':
      version => $version;
    }

    # NOTE: This relationship is also handled by
    # Rvm::System/Exec['rvm::dependencies']
    Class['rvm::dependencies'] -> Class['rvm::system']
  }
}
