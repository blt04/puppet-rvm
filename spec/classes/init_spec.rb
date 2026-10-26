# frozen_string_literal: true

require 'spec_helper'

describe 'rvm' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts.merge(rvm_version: '', root_home: '/root') }

      context 'default parameters', :compile do
        it { is_expected.not_to contain_class('rvm::dependencies') }
        it { is_expected.to contain_class('rvm::system') }
      end

      context 'with install_rvm false', :compile do
        let(:params) do
          {
            install_rvm: false,
          }
        end

        it { is_expected.not_to contain_class('rvm::dependencies') }
        it { is_expected.not_to contain_class('rvm::system') }
      end

      context 'with system_rubies', :compile do
        let(:params) do
          {
            system_rubies: {
              'ruby-1.9' => {
                'default_use' => true,
              },
              'ruby-2.0' => {},
            },
          }
        end

        it {
          expect(subject).to contain_rvm_system_ruby('ruby-1.9').with(ensure: 'present',
                                                                      default_use: true)
        }

        it {
          expect(subject).to contain_rvm_system_ruby('ruby-2.0').with(ensure: 'present',
                                                                      default_use: nil)
        }
      end

      context 'with system_users', if: os_facts[:kernel] == 'Linux' do
        let(:params) { { system_users: %w[john doe] } }

        it { is_expected.to contain_rvm__system_user('john') }
        it { is_expected.to contain_rvm__system_user('doe') }
      end

      context 'with gnupg key id default value', :compile do
        it { is_expected.to contain_gnupg_key('39499BDB') }
        it { is_expected.to contain_gnupg_key('D39DC0E3') }
      end
    end
  end
end
