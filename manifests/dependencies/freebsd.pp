class rvm::dependencies::freebsd {

  if ! defined(Package['bash'])            { package { 'bash':            ensure => installed, root => true } }
  if ! defined(Package['which'])           { package { 'which':           ensure => installed, root => true } }
  if ! defined(Package['gcc'])             { package { 'gcc':             ensure => installed, root => true } }
  if ! defined(Package['gcc-c++'])         { package { 'gcc-c++':         ensure => installed, root => true } }
  if ! defined(Package['make'])            { package { 'make':            ensure => installed, root => true } }
  if ! defined(Package['gettext-devel'])   { package { 'gettext-devel':   ensure => installed, root => true } }
  if ! defined(Package['expat-devel'])     { package { 'expat-devel':     ensure => installed, root => true } }
  if ! defined(Package['libcurl-devel'])   { package { 'libcurl-devel':   ensure => installed, root => true } }
  if ! defined(Package['zlib-devel'])      { package { 'zlib-devel':      ensure => installed, root => true } }
  if ! defined(Package['openssl-devel'])   { package { 'openssl-devel':   ensure => installed, root => true } }
  if ! defined(Package['perl'])            { package { 'perl':            ensure => installed, root => true } }
  if ! defined(Package['cpio'])            { package { 'cpio':            ensure => installed, root => true } }
  if ! defined(Package['expat-devel'])     { package { 'expat-devel':     ensure => installed, root => true } }
  if ! defined(Package['gettext-devel'])   { package { 'gettext-devel':   ensure => installed, root => true } }
  if ! defined(Package['wget'])            { package { 'wget':            ensure => installed, root => true } }
  if ! defined(Package['bzip2'])           { package { 'bzip2':           ensure => installed, root => true } }
  if ! defined(Package['sendmail'])        { package { 'sendmail':        ensure => installed, root => true } }
  if ! defined(Package['mailx'])           { package { 'mailx':           ensure => installed, root => true } }
  if ! defined(Package['libxml2'])         { package { 'libxml2':         ensure => installed, root => true } }
  if ! defined(Package['libxml2-devel'])   { package { 'libxml2-devel':   ensure => installed, root => true } }
  if ! defined(Package['libxslt'])         { package { 'libxslt':         ensure => installed, root => true } }
  if ! defined(Package['libxslt-devel'])   { package { 'libxslt-devel':   ensure => installed, root => true } }
  if ! defined(Package['readline-devel'])  { package { 'readline-devel':  ensure => installed, root => true } }
  if ! defined(Package['patch'])           { package { 'patch':           ensure => installed, root => true } }
  if ! defined(Package['git'])             { package { 'git':             ensure => installed, root => true } }
}
