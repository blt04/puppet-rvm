class rvm::passenger::apache(
  $ruby_version,
  $version,
  $mininstances = '1',
  $maxpoolsize = '6',
  $poolidletime = '300',
  $maxinstancesperapp = '0',
  $spawnmethod = 'smart-lv2'
) {

  case $operatingsystem {
    Ubuntu: { include rvm::passenger::apache::ubuntu::pre }
    CentOS,RedHat: { include rvm::passenger::apache::centos::pre }
  }

  class {
    'rvm::passenger::gem':
      ruby_version => $ruby_version,
      version => $version,
  }

  # TODO: How can we get the gempath automatically using the ruby version
  # Can we read the output of a command into a variable?
  # e.g. $gempath = `usr/local/rvm/bin/rvm ${ruby_version} exec rvm gemdir`
  $gempath = "${rvm::system::rvmpath}/gems/${ruby_version}/gems"

  case $operatingsystem {
    Ubuntu: {
      class { 'rvm::passenger::apache::ubuntu::post':
        ruby_version       => $ruby_version,
        version            => $version,
        rvm_prefix         => $rvm_prefix,
        mininstances       => $mininstances,
        maxpoolsize        => $maxpoolsize,
        poolidletime       => $poolidletime,
        maxinstancesperapp => $maxinstancesperapp,
        spawnmethod        => $spawnmethod,
        gempath            => $gempath,
      }
    }
    CentOS,RedHat: {
      class { 'rvm::passenger::apache::centos::post':
        ruby_version       => $ruby_version,
        version            => $version,
        rvm_prefix         => $rvm_prefix,
        mininstances       => $mininstances,
        maxpoolsize        => $maxpoolsize,
        poolidletime       => $poolidletime,
        maxinstancesperapp => $maxinstancesperapp,
        spawnmethod        => $spawnmethod,
        gempath            => $gempath,
      }
    }
  }
}
