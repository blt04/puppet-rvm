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
        case os_facts[:operatingsystemmajrelease]
        when '5'
          if ['CentOS', 'RedHat'].include? os_facts[:operatingsystem]
            it { is_expected.to contain_package('autoconf') }
            it { is_expected.to contain_package('curl-devel') }
            it { is_expected.not_to contain_package('libcurl-devel') }
          end
        when '6', '7'
          it { is_expected.to contain_package('libcurl-devel') }
          it { is_expected.not_to contain_package('autoconf') }
          it { is_expected.not_to contain_package('curl-devel') }
        end
      when 'Debian'
        it { is_expected.to contain_package('autoconf') }
        it { is_expected.to contain_package('build-essential') }
        it { is_expected.not_to contain_package('which') }
        it { is_expected.not_to contain_package('gcc') }
      end
    end
  end
end


