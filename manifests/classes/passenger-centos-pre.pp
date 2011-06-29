class rvm::passenger::apache::centos::pre {

  # Dependencies
  if ! defined(Package["httpd"]) { package { "httpd": ensure => installed } }
  if ! defined(Package["httpd-devel"]) { package { "httpd-devel":  ensure => installed } }

}