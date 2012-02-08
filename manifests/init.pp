class rvm($version='latest', $install_rvm=true, $use_rpm=false) {
  stage { 'rvm-install': before => Stage['main'] }

  if $install_rvm {
    class {
      'rvm::dependencies': stage => 'rvm-install';
      'rvm::system':
        stage   => 'rvm-install',
        version => $version,
        use_rpm => $use_rpm;
    }
  }
}
