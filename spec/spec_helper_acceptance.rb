require 'puppet'
require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

unless (ENV['RS_PROVISION'] == 'no' || ENV['BEAKER_provision'] == 'no')
  hosts.each do |host|
    if host.is_pe?
      install_pe
    else
      install_puppet
      on host, "mkdir -p #{host['distmoduledir']}"
    end
  end
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.before(:each) do
    Puppet::Util::Log.level = :warning
    Puppet::Util::Log.newdestination(:console)
  end

  c.before :suite do
    # Install module and dependencies
    puppet_module_install(:source => proj_root, :module_name => 'rvm')

    hosts.each do |host|
      if fact('osfamily') == 'RedHat'
        on host, puppet('module','install','stahnma/epel'), { :acceptable_exit_codes => [0,1] }
      end
      on host, puppet('module','install','puppetlabs-stdlib'), { :acceptable_exit_codes => [0,1] }
      # temp change while waiting for latest apache release
      # install apache (and dependencides) from git instead of module
      # aleady installed in system_helper_acceptance
      on host, puppet('module','install','puppetlabs/concat','--version','>= 1.0.0'), { :acceptable_exit_codes => [0,1] }
      # while waiting for forge release of apache::mod updates
      install_package host, 'git'
      on host, "test -d /etc/puppet/modules/apache || /usr/bin/git clone https://github.com/puppetlabs/puppetlabs-apache.git /etc/puppet/modules/apache"
      # on host, puppet('module','install','puppetlabs/apache','--version','0.9.0'), { :acceptable_exit_codes => [0,1] }
    end
  end
end
