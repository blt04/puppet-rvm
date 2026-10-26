# Install RVM, create system user a install system level rubies
class rvm (
  Optional[String[1]] $version = undef,
  Optional[String[1]] $install_from = undef,
  Boolean $install_rvm = true,
  Boolean $install_dependencies = false,
  Boolean $manage_rvmrc = true,
  Array[String[1]] $system_users = [],
  Hash[String[1], Any] $system_rubies = {},
  Hash[String[1], Any] $rvm_gems = {},
  Optional[String[1]] $proxy_url = undef,
  Optional[String[1]] $no_proxy = undef,
  Array[Hash[String[1], String[1]]] $signing_keys = $rvm::params::signing_keys,
  Boolean $include_gnupg = true,
  Boolean $manage_wget = true,
) inherits rvm::params {
  if $install_rvm {
    # rvm has now autolibs enabled by default so let it manage the dependencies
    if $install_dependencies {
      class { 'rvm::dependencies':
        before => Class['rvm::system'],
      }
    }

    if $manage_rvmrc {
      include rvm::rvmrc
    }

    class { 'rvm::system':
      version       => $version,
      proxy_url     => $proxy_url,
      no_proxy      => $no_proxy,
      signing_keys  => $signing_keys,
      install_from  => $install_from,
      include_gnupg => $include_gnupg,
      manage_wget   => $manage_wget,
    }
  }

  rvm::system_user { $system_users: }
  create_resources('rvm_system_ruby', $system_rubies, { 'ensure' => present, 'proxy_url' => $proxy_url, 'no_proxy' => $no_proxy })
  create_resources('rvm_gem', $rvm_gems)
}
