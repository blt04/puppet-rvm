require 'rake/clean'
require 'puppet-lint/tasks/puppet-lint'
require 'rspec/core/rake_task'

CLEAN.include('pkg')

PuppetLint.configuration.send("disable_80chars")

desc "Run module RSpec tests."
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ["--format", "doc", "--color"]
  t.pattern = 'spec/*/*_spec.rb'
end

desc "Create a Puppet module."
task :build => [:clean, :spec] do
  sh 'puppet-module build'
end

task :default => :build
