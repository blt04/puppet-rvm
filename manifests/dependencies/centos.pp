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
    # Make sure we have the semanage command
    if ! defined(Package['policycoreutils-python']) {
      package { 'policycoreutils-python': ensure => present }
    }

    # Give rvm-managed files the right contexts
    exec { 'rvm-selinux-contexts':
      command =>
        "/usr/sbin/semanage fcontext -a -t bin_t '/usr/(local|lib)/rvm/wrappers/ruby-.*' &&
        /usr/sbin/semanage fcontext -a -t bin_t '/usr/(local|lib)/rvm/rubies/ruby-.*/bin(/.*)?' &&
        /usr/sbin/semanage fcontext -a -t lib_t '/usr/(local|lib)/rvm/gems/ruby-.*/gems/passenger-.*/ext/apache2(/.*)?' &&
        /usr/sbin/semanage fcontext -a -t passenger_exec_t '/usr/(local|lib)/rvm/gems/ruby-.*/gems/passenger-.*/agents/PassengerWatchdog' &&
        /usr/sbin/semanage fcontext -a -t passenger_exec_t '/usr/(local|lib)/rvm/gems/ruby-.*/gems/passenger-.*/agents/PassengerLoggingAgent' &&
        /usr/sbin/semanage fcontext -a -t passenger_exec_t '/usr/(local|lib)/rvm/gems/ruby-.*/gems/passenger-.*/agents/apache2/PassengerHelperAgent'",
      logoutput => on_failure,
      require   => Package['policycoreutils-python'],
      unless    => '/usr/sbin/semanage fcontext -l | /bin/grep -q rvm',
    }
  }
}
