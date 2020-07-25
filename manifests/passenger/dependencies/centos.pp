# Package dependencies for Passenger on RedHat
class rvm::passenger::dependencies::centos {
  $version = $facts['os']['name'] ? {
    'Amazon' => '6.x',
    default  => $facts['os']['release']['full'],
  }

  case $version {
    /^[67]\..*/: {
      ensure_packages(['libcurl-devel'])
    }
    default: {
      ensure_packages(['curl-devel'])
    }
  }
}
