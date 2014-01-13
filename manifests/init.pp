class rvm(
  $version=undef,
  $install_rvm=true,
  $system_users=[],
  $system_rubies={}) {

  if $install_rvm {
    class { 'rvm::dependencies': }

    class { 'rvm::system':
      version => $version;
    }

    # NOTE: This relationship is also handled by
    # Rvm::System/Exec['rvm::dependencies']
    Class['rvm::dependencies'] -> Class['rvm::system']
  }

  rvm::system_user{ $system_users: }
  create_resources('rvm_system_ruby', $system_rubies, {'ensure' => present})
}
