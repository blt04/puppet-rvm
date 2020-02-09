require 'spec_helper'

describe 'rvm' do

  let(:facts) { {
    rvm_version: '',
    root_home: '/root'
  }}

  context 'default parameters', :compile do
    it { is_expected.not_to contain_class('rvm::dependencies') }
    it { is_expected.to contain_class('rvm::system') }
  end

  context 'with install_rvm false', :compile do
    let(:params) { {
      install_rvm: false
    }}
    it { is_expected.not_to contain_class('rvm::dependencies') }
    it { is_expected.not_to contain_class('rvm::system') }
  end

  context 'with system_rubies', :compile do
    let(:params) { {
      system_rubies: {
        'ruby-1.9' => {
          'default_use' => true
        },
        'ruby-2.0' => {}
      }
    }}
    it { is_expected.to contain_rvm_system_ruby('ruby-1.9').with({
      ensure: 'present',
      default_use: true
    }) }
    it { is_expected.to contain_rvm_system_ruby('ruby-2.0').with({
      ensure: 'present',
      default_use: nil
    }) }
  end

  context 'with system_users', :compile do
    let(:params) { { system_users: ['john', 'doe'] } }
    it { is_expected.to contain_rvm__system_user('john') }
    it { is_expected.to contain_rvm__system_user('doe') }
  end

  context 'with no gnupg key id', :compile do
    let(:params) { { gnupg_key_id: false } }
    it { is_expected.not_to contain_gnupg_key('rvm_D39DC0E3') }
    it { is_expected.not_to contain_gnupg_key('rvm_') }
  end

end
