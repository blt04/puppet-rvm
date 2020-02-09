require 'spec_helper'

describe 'rvm_wrapper' do

  let(:title) { 'god' }
  let(:params) { {
    target_ruby: 'ruby-1.9.3-p448',
    prefix: 'bootup',
    ensure: 'present'
  }}

  context 'when using default parameters', :compile do
    it { is_expected.to contain_rvm_wrapper('god').with_prefix('bootup') }
  end
end
