require 'spec_helper'

describe 'rvm' do
  context "default parameters" do
    it { should contain_class('rvm::dependencies') }
    it { should contain_class('rvm::system') }
  end

  context "with install_rvm false" do
    let(:params) {{
      :install_rvm => false
    }}
    it { should_not contain_class('rvm::dependencies') }
    it { should_not contain_class('rvm::system') }
  end
end
