require 'spec_helper'

describe 'rvm::gnupg_key' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}", :compile do
      let(:facts) { os_facts.merge(gnupg_installed: true) }

      it { is_expected.to contain_gnupg_key('rvm_39499BDB') }
    end
  end
end
