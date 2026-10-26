# frozen_string_literal: true

require 'spec_helper_acceptance'

# rubocop:disable RSpec/MultipleMemoizedHelpers
describe 'rvm' do
  # host variables
  let(:osfamily) { fact('os.family') }
  let(:osname) { fact('os.name') }
  let(:osversion) { fact('os.release.major') }

  # rvm config
  let(:rvm_path) { '/usr/local/rvm/' }

  # list of currently supported interpreters
  # https://github.com/rvm/rvm/blob/master/config/known

  # ruby 3.3 config
  let(:ruby33_version) { 'ruby-3.3.11' } # chosen for RVM binary support across nodesets
  let(:ruby33_environment) { "#{rvm_path}environments/#{ruby33_version}" }
  let(:ruby33_bin) { "#{rvm_path}rubies/#{ruby33_version}/bin/" }
  let(:ruby33_gems) { "#{rvm_path}gems/#{ruby33_version}/gems/" }
  let(:ruby33_gemset) { 'myproject' }
  let(:ruby33_and_gemset) { "#{ruby33_version}@#{ruby33_gemset}" }

  # ruby 2.6 config
  let(:ruby32_version) { 'ruby-3.2.11' } # chosen for RVM binary support across nodesets
  let(:ruby32_environment) { "#{rvm_path}environments/#{ruby32_version}" }
  let(:ruby32_bin) { "#{rvm_path}rubies/#{ruby32_version}/bin/" }
  let(:ruby32_gems) { "#{rvm_path}gems/#{ruby32_version}/gems/" }
  let(:ruby32_gemset) { 'myproject' }
  let(:ruby32_and_gemset) { "#{ruby32_version}@#{ruby32_gemset}" }

  # passenger baseline configuration
  let(:service_name) do
    case osfamily
    when 'Debian'
      'apache2'
    when 'RedHat'
      'httpd'
    end
  end
  let(:mod_dir) do
    case osfamily
    when 'Debian'
      '/etc/apache2/mods-available/'
    when 'RedHat'
      '/etc/httpd/conf.d/'
    end
  end
  let(:rackapp_user) do
    case osfamily
    when 'Debian'
      'www-data'
    when 'RedHat'
      'apache'
    end
  end
  let(:rackapp_group) do
    case osfamily
    when 'Debian'
      'www-data'
    when 'RedHat'
      'apache'
    end
  end
  let(:conf_file) { "#{mod_dir}passenger.conf" }
  let(:load_file) { "#{mod_dir}passenger.load" }

  # baseline manifest
  let(:manifest) do
    <<-EOS
      if $facts['os']['familiy'] == 'RedHat' {
        class { 'epel':
          before => Class['rvm'],
        }
      }

      class { 'rvm': }
      -> rvm::system_user { 'vagrant': }
    EOS
  end

  it 'rvm should install and configure system user' do
    # Run it twice and test for idempotency
    apply_manifest(manifest, catch_failures: true)
    apply_manifest(manifest, catch_changes: true)
    shell('/usr/local/rvm/bin/rvm list') do |r|
      expect(r.stdout).to include('# No rvm rubies installed yet.')
      expect(r.exit_code).to be_zero
    end
  end

  context 'when installing rubies' do
    let(:manifest) do
      super() + <<-EOS
        rvm_system_ruby {
          '#{ruby33_version}':
            ensure      => 'present',
            default_use => false;
          '#{ruby32_version}':
            ensure      => 'present',
            default_use => false;
        }
      EOS
    end

    it 'installs with no errors' do
      apply_manifest(manifest, catch_failures: true)
      apply_manifest(manifest, catch_changes: true)
    end

    it 'reflects installed rubies' do
      shell('/usr/local/rvm/bin/rvm list') do |r|
        expect(r.stdout).to include(ruby33_version).and include(ruby32_version)
        expect(r.exit_code).to be_zero
      end
    end

    context 'and installing gems' do
      let(:gem_name) { 'simple-rss' } # used because has no dependencies
      let(:gem_version) { '1.3.1' }

      let(:gemset_manifest) do
        manifest + <<-EOS
          rvm_gemset {
            '#{ruby33_and_gemset}':
              ensure  => present,
              require => Rvm_system_ruby['#{ruby33_version}'];
          }
          rvm_gem {
            '#{ruby33_and_gemset}/#{gem_name}':
              ensure  => '#{gem_version}',
              require => Rvm_gemset['#{ruby33_and_gemset}'];
          }
          rvm_gemset {
            '#{ruby32_and_gemset}':
              ensure  => present,
              require => Rvm_system_ruby['#{ruby32_version}'];
          }
          rvm_gem {
            '#{ruby32_and_gemset}/#{gem_name}':
              ensure  => '#{gem_version}',
              require => Rvm_gemset['#{ruby32_and_gemset}'];
          }
        EOS
      end

      it 'installs with no errors' do
        apply_manifest(gemset_manifest, catch_failures: true)
        apply_manifest(gemset_manifest, catch_changes: true)
      end

      it 'reflects installed gems and gemsets' do
        shell("/usr/local/rvm/bin/rvm #{ruby33_version} gemset list") do |r|
          expect(r.stdout).to include("\n=> (default)").and include("\n   global").and include("\n   #{ruby33_gemset}")
          expect(r.exit_code).to be_zero
        end

        shell("/usr/local/rvm/bin/rvm #{ruby32_version} gemset list") do |r|
          expect(r.stdout).to include("\n=> (default)").and include("\n   global").and include("\n   #{ruby32_gemset}")
          expect(r.exit_code).to be_zero
        end
      end
    end
  end

  context 'when installing jruby' do
    let(:jruby_version) { 'jruby' }

    let(:manifest) do
      super() + <<-EOS
        class { 'java': }
        -> rvm_system_ruby { '#{jruby_version}':
          ensure      => 'present',
          default_use => false;
        }
      EOS
    end

    it 'installs with no errors' do
      apply_manifest(manifest, catch_failures: true)
      apply_manifest(manifest, catch_changes: true)
    end

    it 'reflects installed rubies' do
      shell('/usr/local/rvm/bin/rvm list') do |r|
        expect(r.stdout).to include(jruby_version)
        expect(r.exit_code).to be_zero
      end
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
