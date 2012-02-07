class rvm::dependencies::centos {

  if ! defined(Package['which'])           { package { 'which':           ensure => installed } }
  if ! defined(Package['gcc'])             { package { 'gcc':             ensure => installed } }
  if ! defined(Package['gcc-c++'])         { package { 'gcc-c++':         ensure => installed } }
  if ! defined(Package['make'])            { package { 'make':            ensure => installed } }
  if ! defined(Package['gettext-devel'])   { package { 'gettext-devel':   ensure => installed } }
  if ! defined(Package['expat-devel'])     { package { 'expat-devel':     ensure => installed } }
  if ! defined(Package['libcurl-devel'])   { package { 'libcurl-devel':   ensure => installed } }
  if ! defined(Package['zlib-devel'])      { package { 'zlib-devel':      ensure => installed } }
  if ! defined(Package['openssl-devel'])   { package { 'openssl-devel':   ensure => installed } }
  if ! defined(Package['perl'])            { package { 'perl':            ensure => installed } }
  if ! defined(Package['cpio'])            { package { 'cpio':            ensure => installed } }
  if ! defined(Package['expat-devel'])     { package { 'expat-devel':     ensure => installed } }
  if ! defined(Package['gettext-devel'])   { package { 'gettext-devel':   ensure => installed } }
  if ! defined(Package['wget'])            { package { 'wget':            ensure => installed } }
  if ! defined(Package['bzip2'])           { package { 'bzip2':           ensure => installed } }
  if ! defined(Package['sendmail'])        { package { 'sendmail':        ensure => installed } }
  if ! defined(Package['mailx'])           { package { 'mailx':           ensure => installed } }
  if ! defined(Package['libxml2'])         { package { 'libxml2':         ensure => installed } }
  if ! defined(Package['libxml2-devel'])   { package { 'libxml2-devel':   ensure => installed } }
  if ! defined(Package['libxslt'])         { package { 'libxslt':         ensure => installed } }
  if ! defined(Package['libxslt-devel'])   { package { 'libxslt-devel':   ensure => installed } }
  if ! defined(Package['readline-devel'])  { package { 'readline-devel':  ensure => installed } }
  if ! defined(Package['patch'])           { package { 'patch':           ensure => installed } }
  if ! defined(Package['git'])             { package { 'git':             ensure => installed } }

  # If we have selinux, prepare to set the correct file contexts
  # On RHEL6 with a current policy, these are automatic when passenger is
  # installed in the system ruby gems directory, but the alternative rvm
  # location means they don't get set correctly by the default policy
  if $selinux == 'true' {
    # Make sure we have semanage and restorecon commands
    if ! defined(Package['policycoreutils-python']) {
      package { 'policycoreutils-python': ensure => present }
    }

    # Install a hook into rvm to correct contexts after ruby installs
    file { '/root/.rvm/hooks':
      ensure => directory,
      owner  => root,
      group  => 0,
      mode   => 0755,
    }
    file { '/root/.rvm/hooks/after_install':
      source => 'puppet:///modules/rvm/after_install',
      owner   => root,
      group   => 0,
      mode    => 0755,
    }
  }
}
