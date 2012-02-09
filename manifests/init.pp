class rvm(
  $version = 'latest',
  $install_rvm = true,
  $use_pkg = false,
  $rstage = 'rvm-install'
) {
  stage { 'rvm-install': before => Stage['main'] }

  if $install_rvm {
    class {
      'rvm::dependencies': stage => $rstage;
      'rvm::system':
        stage   => $rstage,
        version => $version,
        use_pkg => $use_pkg;
    }
  }
}
