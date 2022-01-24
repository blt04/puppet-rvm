# Install the RVM system
class rvm::system (
  $version=undef,
  $install_from=undef,
  $proxy_url=undef,
  $no_proxy=undef,
  $key_server=undef,
  $home=$facts['root_home'],
  $gnupg_key_id=$rvm::params::gnupg_key_id
) inherits rvm::params {
  $actual_version = $version ? {
    undef     => 'latest',
    'present' => 'latest',
    default   => $version,
  }

  # curl needs to be installed
  if ! defined(Package['curl']) {
    case $facts['kernel'] {
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

  # install the gpg key
  if $gnupg_key_id {
    class { 'rvm::gnupg_key':
      key_server => $key_server,
      key_id     => $gnupg_key_id,
      before     => Exec['system-rvm'],
    }
  }

  if $install_from {
    file { '/tmp/rvm':
      ensure => directory,
    }

    exec { 'unpack-rvm':
      path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
      command => "tar --strip-components=1 -xzf ${install_from}",
      cwd     => '/tmp/rvm',
    }

    exec { 'system-rvm':
      path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
      command     => './install --auto-dotfiles',
      cwd         => '/tmp/rvm',
      creates     => '/usr/local/rvm/bin/rvm',
      environment => $environment,
    }
  }
  else {
    exec { 'system-rvm':
      path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
      command     => "curl -fsSL https://get.rvm.io | bash -s -- --version ${actual_version}",
      creates     => '/usr/local/rvm/bin/rvm',
      environment => $environment,
    }
  }

  # the fact won't work until rvm is installed before puppet starts
  if $facts['rvm_version'] and !empty($facts['rvm_version']) {
    if ($version != undef) and ($version != present) and ($version != $facts['rvm_version']) {
      if defined(Class['rvm::gnupg_key']) {
        Class['rvm::gnupg_key'] -> Exec['system-rvm-get']
      }

      # Update the rvm installation to the version specified
      notify { 'rvm-get_version':
        message => "RVM updating from version ${facts['rvm_version']} to ${version}",
      }
      -> exec { 'system-rvm-get':
        path        => '/usr/local/rvm/bin:/usr/bin:/usr/sbin:/bin',
        command     => "rvm get ${version}",
        before      => Exec['system-rvm'], # so it doesn't run after being installed the first time
        environment => $environment,
      }
    }
  }
}
