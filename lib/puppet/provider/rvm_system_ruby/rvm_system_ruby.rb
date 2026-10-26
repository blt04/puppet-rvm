# frozen_string_literal: true

Puppet::Type.type(:rvm_system_ruby).provide(:rvm) do
  desc 'Ruby RVM support.'

  has_command(:rvmcmd, '/usr/local/rvm/bin/rvm') do
    environment HOME: ENV.fetch('HOME', nil)
  end

  def create
    if resource[:mount_from]
      mount
    else
      install
    end
    set_default if resource.value(:default_use)
  end

  def destroy
    rvmcmd 'uninstall', resource[:name]
  end

  def exists?
    rvmcmd('list', 'strings').split("\n").any? do |line|
      line =~ Regexp.new(Regexp.escape(resource[:name]))
    end
  rescue Puppet::ExecutionFailure => e
    raise Puppet::Error, "Could not list RVMs: #{e}"
  end

  def default_use
    rvmcmd('list', 'default').split("\n").any? do |line|
      line =~ Regexp.new(Regexp.escape(resource[:name]))
    end
  rescue Puppet::ExecutionFailure => e
    raise Puppet::Error, "Could not list default RVM: #{e}"
  end

  def default_use=(value)
    set_default if value
  end

  def set_default
    rvmcmd 'alias', 'create', 'default', resource[:name]
  end

  private

  def install
    unless resource[:proxy_url].nil?
      ENV['http_proxy']  = resource[:proxy_url]
      ENV['https_proxy'] = resource[:proxy_url]
      ENV['no_proxy'] = resource[:no_proxy] unless resource[:no_proxy].nil?
    end
    options = Array(resource[:build_opts])
    options << "--autolibs #{resource[:autolib_mode]}" if resource[:autolib_mode]
    if resource[:proxy_url] && !resource[:proxy_url].empty?
      rvmcmd 'install', resource[:name], '--proxy', resource[:proxy_url], *options
    else
      rvmcmd 'install', resource[:name], *options
    end
  end

  def mount
    rvmcmd 'mount', resource[:mount_from]
  end
end
