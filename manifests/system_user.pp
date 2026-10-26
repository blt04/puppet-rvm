# Create a user that belongs to the correct group to have access to RVM
define rvm::system_user (
  Boolean $create = true,
  Optional[Boolean] $manage_group = undef
) {
  if $create {
    ensure_resource('user', $name, {
      'ensure' => 'present',
      'system' => true,
    })
    User[$name] -> Exec["rvm-system-user-${name}"]
  }

  include rvm::params
  if pick($manage_group, $rvm::params::manage_group) {
    include rvm::group
    Group[$rvm::params::group] -> Exec["rvm-system-user-${name}"]
  }

  $add_to_group = $facts['os']['family'] ? {
    'Darwin'  => "/usr/sbin/dseditgroup -o edit -a ${name} -t user ${rvm::params::group}",
    'FreeBSD' => "/usr/sbin/pw groupmod ${rvm::params::group} -m ${name}",
    default   => "/usr/sbin/usermod -a -G ${rvm::params::group} ${name}",
  }
  $check_in_group = $facts['os']['family'] ? {
    'Darwin'  => "/usr/bin/dsmemberutil checkmembership -U ${name} -G ${rvm::params::group} | grep -q 'user is a member'",
    'FreeBSD' => "/usr/bin/id ${name} | grep -q '(${rvm::params::group})'",
    default   => "/bin/cat /etc/group | grep '^${rvm::params::group}:' | grep -qw ${name}",
  }
  exec { "rvm-system-user-${name}":
    command => $add_to_group,
    unless  => $check_in_group,
  }
}
