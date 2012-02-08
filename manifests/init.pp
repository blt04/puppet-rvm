class rvm(
  $version = 'latest',
  $install_rvm = true,
  $use_rpm = false,
  $rstage = 'rvm-install'
) {
  stage { 'rvm-install': before => Stage['main'] }

  if $install_rvm {
    class {
      'rvm::dependencies': stage => $rstage;
      'rvm::system':
        stage   => $rstage,
        version => $version,
        use_rpm => $use_rpm;
    }
  }
}
