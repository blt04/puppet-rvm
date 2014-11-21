class rvm($version=undef, $install_rvm=true) {
  stage { 'rvm-install': before => Stage['main'] }

  if $install_rvm {
      include rvm::dependencies
      include rvm::system
    }

}
