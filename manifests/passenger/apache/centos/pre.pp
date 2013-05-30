class rvm::passenger::apache::centos::pre {
  # Dependencies
  if ! defined(Package['httpd'])       { package { 'httpd':       ensure => present } }
  if ! defined(Package['httpd-devel']) { package { 'httpd-devel': ensure => present } }
  if ! defined(Package['mod_ssl'])     { package { 'mod_ssl':     ensure => present } }
}
