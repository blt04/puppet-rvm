require 'spec_helper'

describe 'rvm::dependencies' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) do
        os_facts
      end

      it { is_expected.to compile.with_all_deps }

      case os_facts[:osfamily]
      when 'RedHat'
        it { is_expected.to contain_package('which') }
        it { is_expected.to contain_package('gcc') }
        it { is_expected.not_to contain_package('build-essential') }
        it { is_expected.to contain_package('libcurl-devel') }
        it { is_expected.not_to contain_package('autoconf') }
      when 'Debian'
        it { is_expected.to contain_package('autoconf') } # rubocop:disable RSpec/RepeatedExample
        it { is_expected.to contain_package('build-essential') }
        it { is_expected.not_to contain_package('which') }
        it { is_expected.not_to contain_package('gcc') }
      end
    end
  end
end
