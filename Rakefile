require 'rake/clean'
require 'puppet-lint/tasks/puppet-lint'

CLEAN.include('spec/fixtures/', 'doc', 'pkg')
CLOBBER.include('.tmp', '.librarian')

require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet_blacksmith/rake_tasks'

PuppetLint.configuration.send("disable_80chars")

# use librarian-puppet to manage fixtures instead of .fixtures.yml
# offers more possibilities like explicit version management, forge downloads,...
task :librarian_spec_prep do
 sh "librarian-puppet install --path=spec/fixtures/modules/"
end
task :spec_prep => :librarian_spec_prep
task :spec_system => :clean

task :default => [:clean, :spec]
