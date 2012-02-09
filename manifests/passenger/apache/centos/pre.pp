class rvm::passenger::apache::centos::pre {
  # Dependencies
  if ! defined(Package['httpd'])       { package { 'httpd':       ensure => installed } }
  if ! defined(Package['httpd-devel']) { package { 'httpd-devel': ensure => installed } }
  if ! defined(Package['mod_ssl'])     { package { 'mod_ssl':     ensure => installed } }

  # Using this temp directory makes passenger work better with selinux
  file { '/var/run/passenger':
    ensure => directory,
    owner  => root,
    group  => 0,
    mode   => 0755,
  }
}
