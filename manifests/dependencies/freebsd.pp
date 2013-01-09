class rvm::dependencies::freebsd {

  if ! defined(Package['bash'])            { package { 'bash':            ensure => installed, provider => "freebsd", source => "http://ftp.freebsd.org/pub/FreeBSD/ports/amd64/packages-9-stable/Latest/", root => true } }
  if ! defined(Package['bison'])           { package { 'bison':           ensure => installed, provider => "freebsd", source => "http://ftp.freebsd.org/pub/FreeBSD/ports/amd64/packages-9-stable/Latest/", root => true } }
  if ! defined(Package['openssl'])         { package { 'openssl':         ensure => installed, provider => "freebsd", source => "http://ftp.freebsd.org/pub/FreeBSD/ports/amd64/packages-9-stable/Latest/", root => true } }
  if ! defined(Package['readline'])        { package { 'readline':        ensure => installed, provider => "freebsd", source => "http://ftp.freebsd.org/pub/FreeBSD/ports/amd64/packages-9-stable/Latest/", root => true } }
  if ! defined(Package['gcc'])             { package { 'gcc':             ensure => installed, provider => "freebsd", source => "http://ftp.freebsd.org/pub/FreeBSD/ports/amd64/packages-9-stable/Latest/", root => true } }
  if ! defined(Package['libxml2'])         { package { 'libxml2':         ensure => installed, provider => "freebsd", source => "http://ftp.freebsd.org/pub/FreeBSD/ports/amd64/packages-9-stable/Latest/", root => true } }
  if ! defined(Package['bzip2'])           { package { 'bzip2':           ensure => installed, provider => "freebsd", source => "http://ftp.freebsd.org/pub/FreeBSD/ports/amd64/packages-9-stable/Latest/", root => true } }
  if ! defined(Package['git'])             { package { 'git':             ensure => installed, provider => "freebsd", source => "http://ftp.freebsd.org/pub/FreeBSD/ports/amd64/packages-9-stable/Latest/", root => true } }
  if ! defined(Package['wget'])            { package { 'wget':            ensure => installed, provider => "freebsd", source => "http://ftp.freebsd.org/pub/FreeBSD/ports/amd64/packages-9-stable/Latest/", root => true } }
  if ! defined(Package['perl'])            { package { 'perl':            ensure => installed, provider => "freebsd", source => "http://ftp.freebsd.org/pub/FreeBSD/ports/amd64/packages-9-stable/Latest/", root => true } }
  if ! defined(Package['gettext'])         { package { 'gettext':         ensure => installed, provider => "freebsd", source => "http://ftp.freebsd.org/pub/FreeBSD/ports/amd64/packages-9-stable/Latest/", root => true } }
  if ! defined(Package['expat'])           { package { 'expat':           ensure => installed, provider => "freebsd", source => "http://ftp.freebsd.org/pub/FreeBSD/ports/amd64/packages-9-stable/Latest/", root => true } }
  if ! defined(Package['libxslt'])         { package { 'libxslt':         ensure => installed, provider => "freebsd", source => "http://ftp.freebsd.org/pub/FreeBSD/ports/amd64/packages-9-stable/Latest/", root => true } }
  if ! defined(Package['patch'])           { package { 'patch':           ensure => installed, provider => "freebsd", source => "http://ftp.freebsd.org/pub/FreeBSD/ports/amd64/packages-9-stable/Latest/", root => true } }
}
