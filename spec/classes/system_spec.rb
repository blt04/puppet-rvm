# frozen_string_literal: true

require 'spec_helper'

describe 'rvm::system' do
  # assume RVM is already installed
  let(:facts) do
    {
      rvm_version: '1.10.0',
      root_home: '/root',
      os: {
        family: 'Debian',
      },
    }
  end

  context 'default parameters', :compile do
    it { is_expected.not_to contain_exec('system-rvm-get') }

    it do
      expect(subject).to contain_exec('system-rvm').with('path' => '/usr/bin:/usr/sbin:/bin:/usr/local/bin')
    end
  end

  context 'with present version', :compile do
    let(:params) { { version: 'present' } }

    it { is_expected.not_to contain_exec('system-rvm-get') }
  end

  context 'with latest version', :compile do
    let(:params) { { version: 'latest' } }

    it { is_expected.to contain_exec('system-rvm-get').with_command('rvm get latest') }
  end

  context 'with explicit version', :compile do
    let(:params) { { version: '1.20.0' } }

    it { is_expected.to contain_exec('system-rvm-get').with_command('rvm get 1.20.0') }
  end

  context 'with proxy_url parameter', :compile do
    let(:params) { { version: 'latest', proxy_url: 'http://dummy.bogus.local:8080' } }

    it { is_expected.to contain_exec('system-rvm-get').with_environment("[\"http_proxy=#{params[:proxy_url]}\", \"https_proxy=#{params[:proxy_url]}\", \"HOME=/root\"]") }
  end

  context 'with no_proxy parameter', :compile do
    let(:params) { { version: 'latest', proxy_url: 'http://dummy.bogus.local:8080', no_proxy: '.example.local' } }

    it { is_expected.to contain_exec('system-rvm-get').with_environment("[\"http_proxy=#{params[:proxy_url]}\", \"https_proxy=#{params[:proxy_url]}\", \"no_proxy=#{params[:no_proxy]}\", \"HOME=/root\"]") }
  end

  context 'with gnupg', :compile do
    let(:pre_condition) { "class { '::gnupg': }" }

    it { is_expected.to contain_gnupg_key('D39DC0E3').with_key_id('D39DC0E3') }
    it { is_expected.to contain_gnupg_key('39499BDB').with_key_id('39499BDB') }
  end

  context 'with gnupg customized', :compile do
    let(:params) { { signing_keys: [{ id: '1234ABCD', source: 'http://example.com/key.asc' }] } }
    let(:pre_condition) { "class { '::gnupg': }" }

    it { is_expected.to contain_gnupg_key('1234ABCD').with_key_id('1234ABCD').with_key_source('http://example.com/key.asc') }
  end
end
