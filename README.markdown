Puppet Module for Ruby Version Manager (RVM)
==============================================

This module handles installing system RVM (also known as multi-user installation
as root) and using it to install rubies and gems.  Support for installing and
configuring passenger is also included.

We are actively using this module.  It works well, but does have some issues you
should be aware of.  Read through the troubleshooting section below if you run in
to problems.


## Add Puppet Module

Before you begin, you must add the RVM module to your Puppet installation.  This can be done with:

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


## Troubleshooting / FAQ

### An error "Could not find a default provider for rvm\_system\_ruby" prevents puppet from running.

This means that puppet cannot find the `/usr/local/bin/rvm` command.  Currently, Puppet does not support making a provider suitable using another resource (late-binding).  You can avoid this error by surrounding your rvm configuration in an if block:

    if $rvm_installed == "true" {
        rvm_system_ruby ...
    }

Do not surround `include rvm::system` in the if block, as this is used to install RVM.

Note:  When setting up a new box, the puppet agent will install RVM on it's first run and Ruby on its second run.


### Some packages/libraries I don't want or need are installed (e.g. build-essential, libc6-dev, libxml2-dev).

RVM works by compiling Ruby from source.  This means you must have all the libraries and binaries required to compile Ruby installed on your system.  I've tried to include these in `manifests/classes/dependencies.rb`.


### It doesn't work on my operating system.

I've only tested this on Ubuntu 10.04 and Ubuntu 11.04.  Other operating systems may require different paths or dependencies.  Feel free to send me a pull request ;)


### Why didn't you just add an RVM provider for the existing package type?

The puppet [package](http://docs.puppetlabs.com/references/latest/type.html#package)
type seems like an obvious place for the RVM provider.  It would be nice if the syntax
for installing Ruby with RVM looked like:

    # NOTE: This does not work
    package {'ruby':
        provider => 'rvm',
        ensure => '1.9.2-p180';
    }

While this may be possible, it becomes harder to manage multiple Ruby versions and
nearly impossible to install gems for a specific Ruby version.  For this reason,
I decided it was best to create a completely new set of types for RVM.


## TODO

* Allow upgrading the RVM version
* Install RVM and Ruby in one pass
