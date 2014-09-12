# Default module parameters
class rvm::params($manage_group = true) {

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
