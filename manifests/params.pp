# Default module parameters
class rvm::params() {

  $group = $::operatingsystem ? {
    default => 'rvm',
  }

  $proxy_url = undef
  $no_proxy = undef

  $gpg_package = $::osfamily ? {
    /(Debian|RedHat)/ => 'gnupg2',
    default => undef,
  }
}
