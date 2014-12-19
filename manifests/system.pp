# Install the RVM system
class rvm::system(
  $version=undef,
  $proxy_url=undef,
  $no_proxy=undef,
  $home='/root') {

  class {'rvm::gpg':}

  $actual_version = $version ? {
    undef     => 'latest',
    'present' => 'latest',
    default   => $version,
  }

  # curl needs to be installed
  if ! defined(Package['curl']) {
    case $::kernel {
      'Linux': {
        ensure_packages(['curl'])
        Package['curl'] -> Exec['system-rvm']
      }
      default: {}
    }
  }
  
  $http_proxy_environment = $proxy_url ? {
    undef   => [],
    default => ["http_proxy=${proxy_url}", "https_proxy=${proxy_url}"]
  }
  $no_proxy_environment = $no_proxy ? {
    undef   => [],
    default => ["no_proxy=${no_proxy}"]
  }
  $proxy_environment = concat($http_proxy_environment, $no_proxy_environment)
  $environment = concat($proxy_environment, ["HOME=${home}"])

  exec { 'system-rvm-gpg-key':
    command     => 'gpg2 --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3',
    path        => $::path,
    environment => $environment,
    unless      => 'gpg2 --list-keys D39DC0E3',
    require     => Class['::rvm::gpg']
  } ->

  exec { 'system-rvm':
    path        => '/usr/bin:/usr/sbin:/bin',
    command     => "/usr/bin/curl -fsSL https://get.rvm.io | bash -s -- --version ${actual_version}",
    creates     => '/usr/local/rvm/bin/rvm',
    environment => $environment,
  }

  # the fact won't work until rvm is installed before puppet starts
  if !empty($::rvm_version) {
    if ($version != undef) and ($version != present) and ($version != $::rvm_version) {
      # Update the rvm installation to the version specified
      notify { 'rvm-get_version':
        message => "RVM updating from version ${::rvm_version} to ${version}",
      } ->
      exec { 'system-rvm-get':
        path        => '/usr/local/rvm/bin:/usr/bin:/usr/sbin:/bin',
        command     => "rvm get ${version}",
        before      => Exec['system-rvm'], # so it doesn't run after being installed the first time
        environment => $environment,
        require     => Exec['system-rvm-gpg-key'],
      }
    }
  }
}
