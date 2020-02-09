require 'spec_helper'
require 'puppet'
require 'puppet/type/rvm_system_ruby'

describe Puppet::Type.type(:rvm_system_ruby) do
  context 'with autolib_mode set' do
    it 'should not raise error' do
      expect do
        Puppet::Type.type(:rvm_system_ruby).new(name: 'ruby-1.9.3-p448', autolib_mode: 'enabled')
      end.not_to raise_error
    end

    it 'should set mode correctly' do
      @system_ruby = Puppet::Type.type(:rvm_system_ruby).new(name: 'jruby-1.7.6', autolib_mode: 'read-fail')
      expect(@system_ruby[:autolib_mode]).to eq('read-fail')
    end
  end

  it 'should error on an incorrect autolib_mode' do
    expect do
      Puppet::Type.type(:rvm_system_ruby).new(name: 'ruby-1.9.3-p448', autolib_mode: 'foo')
    end.to raise_error(Puppet::ResourceError, /Invalid autolib mode: foo/)
  end
end
