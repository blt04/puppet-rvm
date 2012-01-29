class rvm {
  stage { 'rvm-install': before => Stage['main'] }
}
