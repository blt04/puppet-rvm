require 'bundler'
Bundler.require(:rake)
require 'rake/clean'

CLEAN.include('spec/fixtures/', 'doc', 'pkg')
CLOBBER.include('.tmp', '.librarian')

require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet_blacksmith/rake_tasks'

PuppetLint.configuration.send("disable_80chars")

task :default => [:clean, :spec]

desc "Integration test with Vagrant"
task :integration do
  sh %{vagrant destroy --force}
  sh %{vagrant up}
  sh %{vagrant destroy --force}
end
