require 'spec_helper'
describe 'rvm::rvmrc' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) do
        os_facts
      end
      let(:file) { '/etc/rvmrc' }
      let(:pre_condition) { "exec {'system-rvm': path => '/bin'}" }

      context 'default parameters', :compile do
        it { is_expected.to contain_file(file).with_group('rvm') }
        it { is_expected.to contain_file(file).with_content(%r{^umask u=rwx,g=rwx,o=rx$}) }
        it { is_expected.to contain_file(file).with_content(%r{^rvm_autoupdate_flag=0$}) }
        it { is_expected.not_to contain_file(file).with_content(%r{rvm_max_time_flag}) }
      end

      context 'with max_time_flag', :compile do
        let(:params) { { max_time_flag: 20 } }

        it { is_expected.to contain_file(file).with_content(%r{^export rvm_max_time_flag=20$}) }
      end
    end
  end
end
