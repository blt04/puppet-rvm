require 'spec_helper_system'

describe 'rvm' do

  let(:default_ruby_version) { "ruby-1.9.3-p448" }
  let(:default_ruby2_version) { "ruby-2.0.0-p247" }
  let(:build_opts) { "['--binary']" }

  let(:manifest) { <<-EOS
    if $::osfamily == 'RedHat' {
      class { 'epel':
        before => Class['rvm'],
      }
    }

    # ensure rvm doesn't timeout finding binary rubies
    file { '/etc/rvmrc':
      content => 'umask u=rwx,g=rwx,o=rx
                  export rvm_max_time_flag=20',
      mode    => '0664',
      before  => Class['rvm'],
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
          ensure      => 'present',
          default_use => true,
          build_opts  => #{build_opts};
        '#{default_ruby2_version}':
          ensure      => 'present',
          default_use => false,
          build_opts  => #{build_opts};
      }
      EOS
    }

    it 'should install with no errors' do
      puppet_apply(manifest).exit_code.should_not == 1
    end

    context 'and installing gems' do
      let(:manifest) { super() + <<-EOS
          rvm_gemset {
            '#{default_ruby_version}@myproject':
              ensure  => present,
              require => Rvm_system_ruby['#{default_ruby_version}'];
          }
          rvm_gem {
            '#{default_ruby_version}@myproject/rspec':
              ensure  => '2.14.7',
              require => Rvm_gemset['#{default_ruby_version}@myproject'];
          }

          rvm_gemset {
            '#{default_ruby2_version}@myproject':
              ensure  => present,
              require => Rvm_system_ruby['#{default_ruby2_version}'];
          }
          rvm_gem {
            '#{default_ruby2_version}@myproject/rspec':
              ensure  => '2.14.7',
              require => Rvm_gemset['#{default_ruby2_version}@myproject'];
          }
        EOS
      }

      it 'should install with no errors' do
        puppet_apply(manifest).exit_code.should_not == 1
      end
    end
  end

  context 'when installing jruby' do
    let(:manifest) { super() + <<-EOS
      rvm_system_ruby { 'jruby-1.7.6':
        ensure      => 'present',
        default_use => false,
        build_opts  => #{build_opts};
      }
      EOS
    }

    it 'should install with no errors' do
      puppet_apply(manifest).exit_code.should_not == 1
    end
  end

  context 'when installing passenger' do
    before do
      forge_module_install({"puppetlabs/apache" => "0.9.0"})
    end

    let(:manifest) { super() + <<-EOS
      rvm_system_ruby {
        '#{default_ruby_version}':
          ensure      => 'present',
          default_use => true,
      }
      class { 'apache': }
      class { 'rvm::passenger::apache':
        version            => '3.0.11',
        ruby_version       => '#{default_ruby_version}',
        mininstances       => '3',
        maxinstancesperapp => '0',
        maxpoolsize        => '30',
        spawnmethod        => 'smart-lv2',
      }
      EOS
    }

    it 'should install with no errors' do
      # Run it twice and test for idempotency
      puppet_apply(manifest) do |r|
        r.exit_code.should_not == 1
        r.refresh
        r.exit_code.should be_zero
      end

      shell("su - vagrant -c 'rvm #{default_ruby_version} do gem list passenger | grep passenger'").exit_code.should be_zero
    end
  end
end
