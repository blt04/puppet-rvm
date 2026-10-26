# Default module parameters
# @api private
class rvm::params (
  Boolean $manage_group = true,
) {
  $group = 'rvm'

  $signing_keys = [
    { 'id' => 'D39DC0E3', 'source' => 'https://rvm.io/mpapis.asc' },
    { 'id' => '39499BDB', 'source' => 'https://rvm.io/pkuczynski.asc' },
  ]
}
