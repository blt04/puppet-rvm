class rvm::passenger::apache(
  $ruby_version,
  $version,
  $rvm_prefix         = '/usr/local/',
  $mininstances       = '1',
  $maxpoolsize        = '6',
  $poolidletime       = '300',
  $maxinstancesperapp = '0',
  $spawnmethod        = 'smart-lv2'
) {

  case $::operatingsystem {
    Ubuntu,Debian: { include rvm::passenger::apache::ubuntu::pre }
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
  $gempath = "${rvm_prefix}rvm/gems/${ruby_version}/gems"
  $binpath = "${rvm_prefix}rvm/bin/"

  # central place to keep the everchanging path unter control
  if versioncmp($version, '4.0.7') >= 0 {
    $compiled_module_path = 'buildout'
  } elsif versioncmp($version, '3.9.0') >= 0 {
    $compiled_module_path = 'libout'
  } else {
    $compiled_module_path = 'ext'
  }
  $compiled_module_fn = "${compiled_module_path}/apache2/mod_passenger.so"

  case $::operatingsystem {
    Ubuntu,Debian: {
      if !defined(Class['rvm::passenger::apache::ubuntu::post']) {
        class { 'rvm::passenger::apache::ubuntu::post':
          ruby_version       => $ruby_version,
          version            => $version,
          rvm_prefix         => $rvm_prefix,
          compiled_module_fn => $compiled_module_fn,
          mininstances       => $mininstances,
          maxpoolsize        => $maxpoolsize,
          poolidletime       => $poolidletime,
          maxinstancesperapp => $maxinstancesperapp,
          spawnmethod        => $spawnmethod,
          gempath            => $gempath,
          binpath            => $binpath;
        }
      }
    }
    CentOS,RedHat: {
      if !defined(Class['rvm::passenger::apache::centos::post']) {
        class { 'rvm::passenger::apache::centos::post':
          ruby_version       => $ruby_version,
          version            => $version,
          rvm_prefix         => $rvm_prefix,
          compiled_module_fn => $compiled_module_fn,
          mininstances       => $mininstances,
          maxpoolsize        => $maxpoolsize,
          poolidletime       => $poolidletime,
          maxinstancesperapp => $maxinstancesperapp,
          spawnmethod        => $spawnmethod,
          gempath            => $gempath,
          binpath            => $binpath;
        }
      }
    }
  }
}
