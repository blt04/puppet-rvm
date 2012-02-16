module Puppet
  module Rvm
    def self.rvm_binary
      paths = [
        '/usr/local/rvm/bin/rvm',
        '/usr/local/bin/rvm',
        '/usr/rvm/bin/rvm',
        '/usr/bin/rvm'
      ]
      paths.find {|p| File.exist?(p)} || paths[0]
      end
  end
end
