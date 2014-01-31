require 'rspec-puppet'

fixture_path = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures'))

RSpec.configure do |c|
  c.module_path = File.join(fixture_path, 'modules')
  c.manifest_dir = File.join(fixture_path, 'manifests')
  c.treat_symbols_as_metadata_keys_with_true_values = true
end

shared_examples :compile, :compile => true do
  it { should compile.with_all_deps }
end
