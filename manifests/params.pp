class rvm::params() {

  $group = $::operatingsystem ? {
    default => 'rvm',
  }

}
