# Install RVM, create system user a install system level rubies
class rvm(
  $version=undef,
  $install_rvm=true,
  $install_dependencies=false,
  $manage_rvmrc=true,
  $system_users=[],
  $system_rubies={},
  $proxy_url=$rvm::params::proxy_url,
  $no_proxy=$rvm::params::no_proxy) inherits rvm::params {

  if $install_rvm {

    # rvm has now autolibs enabled by default so let it manage the dependencies
    if $install_dependencies {
      class { 'rvm::dependencies':
        before => Class['rvm::system']
      }
    }

    if $manage_rvmrc {
      ensure_resource('class', 'rvm::rvmrc')
    }

    class { 'rvm::system':
      version   => $version,
      proxy_url => $proxy_url,
      no_proxy  => $no_proxy,
    }
  }

  rvm::system_user{ $system_users: }
  create_resources('rvm_system_ruby', $system_rubies, {'ensure' => present, 'proxy_url' => $proxy_url, 'no_proxy' => $no_proxy})
}
