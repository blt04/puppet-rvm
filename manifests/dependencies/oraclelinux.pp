class rvm::dependencies::oraclelinux {

  if ! defined(Package['which'])           { package { 'which':           ensure => present } }
  if ! defined(Package['gcc'])             { package { 'gcc':             ensure => present } }
  if ! defined(Package['gcc-c++'])         { package { 'gcc-c++':         ensure => present } }
  if ! defined(Package['make'])            { package { 'make':            ensure => present } }
  if ! defined(Package['gettext-devel'])   { package { 'gettext-devel':   ensure => present } }
  if ! defined(Package['expat-devel'])     { package { 'expat-devel':     ensure => present } }
  if ! defined(Package['libcurl-devel'])   { package { 'libcurl-devel':   ensure => present } }
  if ! defined(Package['zlib-devel'])      { package { 'zlib-devel':      ensure => present } }
  if ! defined(Package['openssl-devel'])   { package { 'openssl-devel':   ensure => present } }
  if ! defined(Package['perl'])            { package { 'perl':            ensure => present } }
  if ! defined(Package['cpio'])            { package { 'cpio':            ensure => present } }
  if ! defined(Package['expat-devel'])     { package { 'expat-devel':     ensure => present } }
  if ! defined(Package['gettext-devel'])   { package { 'gettext-devel':   ensure => present } }
  if ! defined(Package['wget'])            { package { 'wget':            ensure => present } }
  if ! defined(Package['bzip2'])           { package { 'bzip2':           ensure => present } }
  if ! defined(Package['libxml2'])         { package { 'libxml2':         ensure => present } }
  if ! defined(Package['libxml2-devel'])   { package { 'libxml2-devel':   ensure => present } }
  if ! defined(Package['libxslt'])         { package { 'libxslt':         ensure => present } }
  if ! defined(Package['libxslt-devel'])   { package { 'libxslt-devel':   ensure => present } }
  if ! defined(Package['readline-devel'])  { package { 'readline-devel':  ensure => present } }
  if ! defined(Package['patch'])           { package { 'patch':           ensure => present } }
  if ! defined(Package['git'])             { package { 'git':             ensure => present } }
}
