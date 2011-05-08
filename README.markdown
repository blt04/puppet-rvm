Puppet Module for Ruby Version Manager (RVM)
==============================================

## Add Puppet Module

Before you begin, you must add RVM module to your Puppet installation.  This can be done with:

    $ git clone git://github.com/blt04/puppet-rvm.git /etc/puppet/modules/rvm

You may now continue configuring RVM resources.


## Install RVM with Puppet

Install RVM with:

    include rvm::system

This will install RVM into `/usr/local/rvm`.

To use RVM without sudo, users need to be added to the `rvm` group.  This can be easily done with:

    rvm::system_user { bturner: ; jdoe: ; jsmith: ; }


## Installing Ruby

You can tell RVM to install one or more Ruby versions with:

    rvm_system_ruby {
      'ruby-1.9.2-p180':
        ensure => 'present',
        default_use => true;
      'ruby-1.8.7-p334':
        ensure => 'present',
        default_use => false;
    }

You should use the full version number.  While the shorthand version may work (e.g. '1.9.2'), the provider will be unable to detect if the correct version is installed.


## Installing Gems

Install a gem with:

    rvm_gem {
      'bundler':
        ruby_version => 'ruby-1.9.2-p180',
        ensure => '1.0.13',
        require => Rvm_system_ruby['ruby-1.9.2-p180'];
    }

The gem will be installed to the default RVM gemset.  This module doesn't allow configuring gemsets.


## Installing Passenger

Install passenger with:

    class {
      'rvm::passenger::apache':
        version => '3.0.7',
        ruby_version => 'ruby-1.9.2-p180',
        mininstances => '3',
        maxinstancesperapp => '0',
        maxpoolsize => '30',
        spawnmethod => 'smart-lv2';
    }


## Troubleshooting

### An error "Could not find a default provider for rvm\_system\_ruby" prevents puppet from running

This means that puppet cannot find the `/usr/local/rvm/bin/rvm` command.  Currently, Puppet does not support making a provider suitable using another resource (late-binding).  When initializing a new server, I usually:

1. Comment out any `rvm_system_ruby` stanzas, leaving only `include rvm::system`.
2. Run the puppet agent once manually.  This will install RVM.
3. Uncomment the `rvm_system_ruby` stanzas.
4. Rerun the puppet agent.  This will install Ruby using RVM.

If anyone has any suggestions on how to improve this, please let me know!


### Some packages/libraries I don't want or need are installed (e.g. build-essential, libc6-dev, libxml2-dev)

RVM works by compiling Ruby from source.  This means you must have all the libraries and binaries required to compile Ruby installed on your system.  I've tried to include these in `manifests/classes/dependencies.rb`.


### It doesn't work on my operating system.

I've only tested this on Ubuntu 10.04 and Ubuntu 11.04.  Other operating systems may require different paths or dependencies.  Feel free to send me a pull request ;)


## TODO

* Allow upgrading the RVM version
* Install RVM and Ruby in one pass without commenting out configuration sections 

