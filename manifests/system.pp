class rvm::system($version = 'latest', $use_rpm = false) {
  # If you set $use_rpm to true, then this module expects that you have made
  # the rvm-ruby RPM available in some yum repository
  # https://github.com/mdkent/rvm-rpm
  if ($use_rpm) {
    $rvmpath = '/usr/lib/rvm'
    package { 'rvm-ruby':
      ensure  => $version,
      require => Class['rvm::dependencies'],
    }
  }
  else {
    $rvmpath = '/usr/local/rvm'
    exec { 'system-rvm':
      path    => '/usr/bin:/usr/sbin:/bin',
      command => "bash -c '/usr/bin/curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer -o /tmp/rvm-installer ;
                  chmod +x /tmp/rvm-installer ;
                  rvm_path=${rvmpath} /tmp/rvm-installer --version ${version} ;
                  rm /tmp/rvm-installer'",
      creates => "${rvmpath}/bin/rvm",
      require => Class['rvm::dependencies'],
    }
  }

  # Install the rvm hook to set selinux file contexts if needed
  if $selinux == 'true' {
    file { "$rvmpath/hooks/after_install":
      source  => 'puppet:///modules/rvm/after_install',
      owner   => root,
      group   => 'rvm',
      mode    => 0755,
      require => $use_rpm ? {
        true  => Package['rvm-ruby'],
        false => Exec['system-rvm'],
      },
    }
  }
}
