class rvm::system(
  $version = 'latest',
  $depstage = 'rvm-install',
  $use_rpm = false
) {

  include rvm
  class {'rvm::dependencies': stage => $depstage;}

  # If you set $use_rpm to true, then this module expects that you have made
  # the rvm-ruby RPM available in some yum repository
  # https://github.com/mdkent/rvm-rpm
  if ($use_rpm) {
    $rvmpath = '/usr/lib/rvm'
    $binpath = '/usr/bin'
    package { 'rvm-ruby':
      ensure  => $version,
      require => Class['rvm::dependencies'],
    }
  }
  else {
    $rvmpath = '/usr/local/rvm'
    $binpath = "${rvmpath}/bin"
    exec { 'system-rvm':
      path    => '/usr/bin:/usr/sbin:/bin',
      command => "bash -c '/usr/bin/curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer -o /tmp/rvm-installer ;
                  chmod +x /tmp/rvm-installer ;
                  rvm_bin_path=${binpath} rvm_man_path=${rvmpath}/man /tmp/rvm-installer --version ${version} ;
                  rm /tmp/rvm-installer'",
      creates => "${binpath}/rvm",
      require => Class['rvm::dependencies'],
    }
  }
}
