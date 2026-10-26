# frozen_string_literal: true

require 'spec_helper'

describe 'rvm::system_user' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) do
        os_facts
      end
      let(:username) { 'johndoe' }
      let(:group) { 'rvm' }
      let(:title) { username }

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_user(username) }
      it { is_expected.to contain_group(group) }

      case os_facts[:os]['family']
      when 'FreeBSD'
        it { is_expected.to contain_exec("rvm-system-user-#{username}").with_command("/usr/sbin/pw groupmod #{group} -m #{username}") }
      when 'Darwin'
        it { is_expected.to contain_exec("rvm-system-user-#{username}").with_command("/usr/sbin/dseditgroup -o edit -a #{username} -t user #{group}") }
      else
        it { is_expected.to contain_exec("rvm-system-user-#{username}").with_command("/usr/sbin/usermod -a -G #{group} #{username}") }
      end
    end
  end
end
