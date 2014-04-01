require 'spec_helper_acceptance'

describe 'rvm' do

  rvm_path = "/usr/local/rvm/"

  ruby19_version = "ruby-1.9.3-p484"
  ruby19_environment = "#{rvm_path}environments/#{ruby19_version}"
  ruby19_bin = "#{rvm_path}rubies/#{ruby19_version}/bin/"
  ruby19_gems = "#{rvm_path}gems/#{ruby19_version}/gems/"
  ruby19_gemset = "myproject"
  ruby19_and_gemset = "#{ruby19_version}@#{ruby19_gemset}"

  ruby20_version = "ruby-2.0.0-p247"
  ruby20_environment = "#{rvm_path}environments/#{ruby20_version}"
  ruby20_bin = "#{rvm_path}rubies/#{ruby20_version}/bin/"
  ruby20_gemset = "myproject"
  ruby20_and_gemset = "#{ruby20_version}@#{ruby20_gemset}"

  base_manifest = <<-EOS
      if $::osfamily == 'RedHat' {
        class { 'epel':
          before => Class['rvm'],
        }
      }

      # ensure rvm doesn't timeout finding binary rubies
      class { 'rvm::rvmrc':
        max_time_flag => '20',
      } ->

      class { 'rvm': } ->
      rvm::system_user { 'vagrant': }
  EOS

  it 'rvm should install and configure system user' do
    # Run it twice and test for idempotency
    manifest = base_manifest
    apply_manifest(manifest, :catch_failures => true)
    apply_manifest(manifest, :catch_changes => true)
    # shell("su - vagrant -c 'rvm list'").exit_code.should be_zero
    shell("/usr/local/rvm/bin/rvm list") do |r|
      r.stdout.should =~ Regexp.new(Regexp.escape("# No rvm rubies installed yet."))
      r.exit_code.should be_zero
    end
  end

  context 'when installing rubies' do

    manifest = base_manifest + <<-EOS
      rvm_system_ruby {
        '#{ruby19_version}':
          ensure      => 'present',
          default_use => true;
        '#{ruby20_version}':
          ensure      => 'present',
          default_use => false;
      }
    EOS

    it 'should install with no errors' do
      apply_manifest(manifest, :catch_failures => true)
      apply_manifest(manifest, :catch_changes => true)
    end

    it 'should reflect installed rubies' do
      shell("/usr/local/rvm/bin/rvm list") do |r|
        r.stdout.should =~ Regexp.new(Regexp.escape("\n=* #{ruby19_version}"))
        r.stdout.should =~ Regexp.new(Regexp.escape("\n   #{ruby20_version}"))
        r.exit_code.should be_zero
      end
    end

    context 'and installing gems' do
      gemset_manifest = manifest + <<-EOS
          rvm_gemset {
            '#{ruby19_and_gemset}':
              ensure  => present,
              require => Rvm_system_ruby['#{ruby19_version}'];
          }
          rvm_gem {
            '#{ruby19_and_gemset}/rspec':
              ensure  => '2.14.1',
              require => Rvm_gemset['#{ruby19_and_gemset}'];
          }
          rvm_gemset {
            '#{ruby20_and_gemset}':
              ensure  => present,
              require => Rvm_system_ruby['#{ruby20_version}'];
          }
          rvm_gem {
            '#{ruby20_and_gemset}/rspec':
              ensure  => '2.14.1',
              require => Rvm_gemset['#{ruby20_and_gemset}'];
          }
      EOS

      it 'should install with no errors' do
        apply_manifest(gemset_manifest, :catch_failures => true)
        apply_manifest(gemset_manifest, :catch_changes => true)
      end

      it 'should reflect installed gems and gemsets' do
        shell(". #{ruby19_environment}; /usr/local/rvm/bin/rvm gemset list") do |r|
          r.stdout.should =~ Regexp.new(Regexp.escape("\n=> (default)"))
          r.stdout.should =~ Regexp.new(Regexp.escape("\n   global"))
          r.stdout.should =~ Regexp.new(Regexp.escape("\n   #{ruby19_gemset}"))
          r.exit_code.should be_zero
        end

        shell(". #{ruby20_environment}; /usr/local/rvm/bin/rvm gemset list") do |r|
          r.stdout.should =~ Regexp.new(Regexp.escape("\n=> (default)"))
          r.stdout.should =~ Regexp.new(Regexp.escape("\n   global"))
          r.stdout.should =~ Regexp.new(Regexp.escape("\n   #{ruby20_gemset}"))
          r.exit_code.should be_zero
        end
      end
    end
  end

  context 'when installing jruby' do
    jruby_version = 'jruby-1.7.6'
    jruby_environment = "#{rvm_path}environments/#{jruby_version}"

    manifest = base_manifest + <<-EOS
      rvm_system_ruby { '#{jruby_version}':
        ensure      => 'present',
        default_use => false;
      }
    EOS

    it 'should install with no errors' do
      apply_manifest(manifest, :catch_failures => true)
      apply_manifest(manifest, :catch_changes => true)
    end

    it 'should reflect installed rubies' do
      shell("/usr/local/rvm/bin/rvm list") do |r|
        r.stdout.should =~ Regexp.new(Regexp.escape("\n   #{jruby_version}"))
        r.exit_code.should be_zero
      end
    end
  end

  context 'when installing passenger' do

    case fact('osfamily')
    when 'Debian'
      service_name = "apache2"
      mod_dir = "/etc/apache2/mods-available/"
      rackapp_user = "www-data"
      rackapp_group = "www-data"
    when 'RedHat'
      service_name = "httpd"
      mod_dir = "/etc/httpd/conf.d/"
      rackapp_user = "apache"
      rackapp_group = "apache"
    end

    conf_file = "#{mod_dir}passenger.conf"
    load_file = "#{mod_dir}passenger.load"
    passenger_version = "3.0.21"
    passenger_ruby = "#{rvm_path}wrappers/#{ruby19_version}/ruby"
    passenger_root = "#{ruby19_gems}passenger-#{passenger_version}"
    passenger_module_path = "#{passenger_root}/ext/apache2/mod_passenger.so"
    
    manifest = base_manifest + <<-EOS
      rvm_system_ruby {
        '#{ruby19_version}':
          ensure      => 'present',
          default_use => true,
      }
      class { 'apache': }
      class { 'rvm::passenger::apache':
        version            => '#{passenger_version}',
        ruby_version       => '#{ruby19_version}',
        mininstances       => '3',
        maxinstancesperapp => '0',
        maxpoolsize        => '30',
        spawnmethod        => 'smart-lv2',
      }
      /* a simple ruby rack 'hello world' app */
      file { '/var/www/passenger':
        ensure  => directory,
        owner   => '#{rackapp_user}',
        group   => '#{rackapp_group}',
        require => Class['rvm::passenger::apache'],
      }
      file { '/var/www/passenger/config.ru':
        ensure  => file,
        owner   => '#{rackapp_user}',
        group   => '#{rackapp_group}',
        content => "app = proc { |env| [200, { \\"Content-Type\\" => \\"text/html\\" }, [\\"hello <b>world</b>\\"]] }\\nrun app",
        require => File['/var/www/passenger'] ,
      }
      apache::vhost { 'passenger.example.com':
        port    => '80',
        docroot => '/var/www/passenger/public',
        docroot_group => '#{rackapp_group}' ,
        docroot_owner => '#{rackapp_user}' ,
        custom_fragment => "PassengerRuby  #{passenger_ruby}\\nRailsEnv  development" ,
        require => File['/var/www/passenger/config.ru'] ,
      }
      host { 'passenger.example.com': ip => '127.0.0.1', }
    EOS

    it 'should install with no errors' do
      # Run it twice and test for idempotency
      apply_manifest(manifest, :catch_failures => true)
      # on some ubuntu systems, puppet detects (apparently non-existent) changes 
      # on subsequent manifest applications, resulting in false test failures
      if fact('operatingsystem') == 'Ubuntu'
        apply_manifest(manifest, :catch_failures => true)
      else
        apply_manifest(manifest, :catch_changes => true)
      end

      shell(". #{ruby19_environment}; #{ruby19_bin}gem list passenger | grep \"passenger (#{passenger_version})\"").exit_code.should be_zero
    end
    
    describe service(service_name) do
      it { should be_enabled }
      it { should be_running }
    end
    
    describe file(conf_file) do
      it { should contain "PassengerRoot \"#{passenger_root}\"" }
      it { should contain "PassengerRuby \"#{passenger_ruby}\"" }
    end

    describe file(load_file) do
      it { should contain "LoadModule passenger_module #{passenger_module_path}" }
    end

    it 'should output status via passenger-status' do
      shell(". #{ruby19_environment}; rvmsudo_secure_path=1 #{rvm_path}/bin/rvmsudo passenger-status") do |r|
        # spacing may vary
        r.stdout.should =~ /[\-]+ General information [\-]+/
        r.stdout.should =~ /max[ ]+= [0-9]+/
        r.stdout.should =~ /count[ ]+= [0-9]+/
        r.stdout.should =~ /active[ ]+= [0-9]+/
        r.stdout.should =~ /inactive[ ]+= [0-9]+/
        r.stdout.should =~ /Waiting on global queue: [0-9]+/
  
        r.exit_code.should == 0
      end
    end

    it 'should answer to passenger.example.com' do
      shell("/usr/bin/curl passenger.example.com:80") do |r|
        r.stdout.should =~ /^hello <b>world<\/b>$/
        r.exit_code.should == 0
      end
    end

  end
end
