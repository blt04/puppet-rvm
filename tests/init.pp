stage { 'epel': before => Stage['rvm-install'] }

class { 'epel': stage => 'epel' } ->
class { 'rvm': }
