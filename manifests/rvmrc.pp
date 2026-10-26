# Configure the /etc/rvmrc file
class rvm::rvmrc (
  Boolean $manage_group = $rvm::params::manage_group,
  $template = 'rvm/rvmrc.erb',
  String[0] $umask = 'u=rwx,g=rwx,o=rx',
  Optional[Integer[0]] $max_time_flag = undef,
  Enum['disabled', 'warn', 'enabled'] $autoupdate_flag = 'disabled',
  Optional[Integer[0, 1]] $silence_path_mismatch_check_flag = undef,
) inherits rvm::params {
  if $manage_group { include rvm::group }

  file { '/etc/rvmrc':
    content => template($template),
    mode    => '0664',
    owner   => 'root',
    group   => $rvm::params::group,
    before  => Exec['system-rvm'],
  }
}
