Puppet Module for Ruby Version Manager (RVM)
==============================================

This module handles installing system RVM (also known as multi-user installation
as root) and using it to install rubies and gems.  Support for installing and
configuring passenger is also included.

We are actively using this module.  It works well, but does have some issues you
should be aware of.  Due to the way puppet works, puppet must run twice before all
rubies and gems are installed.  The first *pass* will install rvm.  The second pass
will install rubies and gems.  If you are running manually, or running in
standalone mode, make sure you run puppet twice to ensure everything is set up
properly.

Please read the troubleshooting section below before opening an issue.


## System Requirements

Puppet 2.6.7 or higher.


## Add Puppet Module

Before you begin, you must add the RVM module to your Puppet installation.  This can be done with:

    $ git clone git://github.com/blt04/puppet-rvm.git /etc/puppet/modules/rvm

Add the following to `manifests/site.pp` or one of your manifest files:

    import "rvm"

Enable plugin synchronization for custom types.  In your puppet.conf (usually in /etc/puppet)
on both the Master and Client ensure you have:

    [main]
        pluginsync = true

You may now continue configuring RVM resources.


## Install RVM with Puppet

Install RVM with:

    include rvm::system

This will install RVM into `/usr/local/rvm`.

To use RVM without sudo, users need to be added to the `rvm` group.  This can be easily done with:

    rvm::system_user { bturner: ; jdoe: ; jsmith: ; }

**NOTE**: You must define a [user](http://docs.puppetlabs.com/references/stable/type.html#user-3) elsewhere in your manifest to use `rvm::system_user`.


## Installing Ruby

You can tell RVM to install one or more Ruby versions with:

    if $rvm_installed == "true" {
      rvm_system_ruby {
        'ruby-1.9.2-p180':
          ensure => 'present',
          default_use => true;
        'ruby-1.8.7-p334':
          ensure => 'present',
          default_use => false;
      }
    }

You should use the full version number.  While the shorthand version may work (e.g. '1.9.2'), the provider will be unable to detect if the correct version is installed.


## Creating Gemsets

Create a gemset with:

    if $rvm_installed == "true" {
        rvm_gemset {
          "ruby-1.9.2-p290@myproject":
            ensure => present,
            require => Rvm_system_ruby['ruby-1.9.2-p290'];
        }
    }


## Installing Gems

Install a gem with:

    if $rvm_installed == "true" {
      rvm_gem {
        'ruby-1.9.2-p290@myproject/bundler':
          ensure => '1.0.18',
          require => Rvm_gemset['ruby-1.9.2-p290@myproject'];
      }
    }

The *name* of the gem should be `<ruby-version>[@<gemset>]/<gemname>`.  For example, you can install bundler for ruby-1.9.2 using `ruby-1.9.2-p290/bundler`.  You could install rails in your project's gemset with: `ruby-1.9.2-p290@myproject/rails`.

Alternatively, you can use this more verbose syntax:

    if $rvm_installed == "true" {
       rvm_gem {
         'bundler':
           name => 'bundler',
           ruby_version => 'ruby-1.9.2-p290',
           ensure => latest,
           require => Rvm_system_ruby['ruby-1.9.2-p334'];
       }
    }


## Installing Passenger

Install passenger with:

    if $rvm_installed == "true" {
      class {
        'rvm::passenger::apache':
          version => '3.0.7',
          ruby_version => 'ruby-1.9.2-p180',
          mininstances => '3',
          maxinstancesperapp => '0',
          maxpoolsize => '30',
          spawnmethod => 'smart-lv2';
      }
    }


## Troubleshooting / FAQ

### An error "Could not find a default provider for rvm\_system\_ruby" prevents puppet from running.

This means that puppet cannot find the `/usr/local/rvm/bin/rvm` command.  Currently, Puppet does not support making a provider suitable using another resource (late-binding).  You can avoid this error by surrounding your rvm configuration in an if block:

    if $rvm_installed == "true" {
        rvm_system_ruby ...
    }

Do not surround `include rvm::system` in the if block, as this is used to install RVM.

Note:  When setting up a new box, the puppet agent will install RVM on it's first run and Ruby on its second run.


### An error "Resource type rvm_gem does not support parameter false" prevents puppet from running.

The RVM module requires Puppet version 2.6.7 or higher.


### Some packages/libraries I don't want or need are installed (e.g. build-essential, libc6-dev, libxml2-dev).

RVM works by compiling Ruby from source.  This means you must have all the libraries and binaries required to compile Ruby installed on your system.  I've tried to include these in `manifests/classes/dependencies.rb`.


### It doesn't work on my operating system.

I've only tested this on Ubuntu 10.04 and Ubuntu 11.04.  [omarqureshi](https://github.com/omarqureshi) was kind enough to add CentOS support.  Other operating systems may require different paths or dependencies.  Feel free to send me a pull request ;)


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
