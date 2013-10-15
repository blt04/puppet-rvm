class rvm::passenger::apache::centos::pre {
  # Dependencies
  ensure_packages(['httpd','httpd-devel','mod_ssl'])
}
