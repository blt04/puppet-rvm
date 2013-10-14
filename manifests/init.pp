class rvm(
  $version = undef,
  $install_rvm = true,
  $url = 'https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer',
  $source = 'github.com/wayneeseguin/rvm') {

  stage { 'rvm-install': before => Stage['main'] }

  if $install_rvm {

    class {'rvm::dependencies':
      stage => 'rvm-install'
    }

    class {'rvm::system':
      stage => 'rvm-install',
      version => $version,
      url => $url,
      source  => $source;
    }

  }
}
