require 'spec_helper_system'

describe 'rvm' do

  let(:default_ruby_version) { "ruby-1.9.3-p448" }

  let(:manifest) { <<-EOS
    if $::osfamily == 'RedHat' {
      class { 'epel':
        before => Class['rvm'],
      }
    }
    class { 'rvm': } ->
    rvm::system_user { 'vagrant': }
    EOS
  }

  it 'rvm should install and configure system user' do
    # Run it twice and test for idempotency
    puppet_apply(manifest) do |r|
      r.exit_code.should_not == 1
      r.refresh
      r.exit_code.should be_zero
    end
  end

  context 'when installing rubies' do
    let(:manifest) { super() + <<-EOS
      rvm_system_ruby {
        '#{default_ruby_version}':
          ensure => 'present',
          default_use => true;
        'ruby-2.0.0-p247':
          ensure => 'present',
          default_use => false;
      }
      EOS
    }

    it 'should install with no errors' do
      puppet_apply(manifest).exit_code.should_not == 1
    end
  end

  context 'when installing jruby' do
    let(:manifest) { super() + <<-EOS
      class { 'java': } ->
      class { 'ant': } ->
      class { 'maven::maven': } ->
      rvm_system_ruby {
        'jruby-1.7.6':
          ensure => 'present',
          default_use => false;
      }
      EOS
    }

    before do
      forge_module_install({
        "puppetlabs/java" => "1.0.1",
        "maestrodev/ant" => "1.0.4",
        "maestrodev/maven" => "1.1.7"})
    end

    it 'should install with no errors' do
      puppet_apply(manifest).exit_code.should_not == 1
    end
  end

  context 'when installing passenger' do
    let(:manifest) { super() + <<-EOS
      rvm_system_ruby {
        '#{default_ruby_version}':
          ensure => 'present',
          default_use => true;
      }
      class {
        'rvm::passenger::apache':
          version => '3.0.11',
          ruby_version => '#{default_ruby_version}',
          mininstances => '3',
          maxinstancesperapp => '0',
          maxpoolsize => '30',
          spawnmethod => 'smart-lv2';
      }
      EOS
    }

    it 'should install with no errors' do
      puppet_apply(manifest).exit_code.should_not == 1
    end
    it 'should have the passenger gem' do
      shell("su - vagrant -c 'rvm #{default_ruby_version} do gem list passenger | grep passenger'").exit_code.should be_zero
    end
  end
end
