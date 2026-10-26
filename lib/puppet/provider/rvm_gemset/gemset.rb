# frozen_string_literal: true

# RVM gemset support
Puppet::Type.type(:rvm_gemset).provide(:gemset) do
  desc 'RVM gemset support.'

  has_command(:rvmcmd, '/usr/local/rvm/bin/rvm') do
    environment HOME: ENV.fetch('HOME', nil)
  end

  def ruby_version
    resource[:ruby_version]
  end

  def gemset_name
    resource[:name]
  end

  def gemsetcommand
    [command(:rvmcmd), ruby_version, 'exec', 'rvm', 'gemset']
  end

  def gemsetcommand_force
    [command(:rvmcmd), ruby_version, 'exec', 'rvm', '--force', 'gemset']
  end

  def gemset_list
    command = gemsetcommand + ['list']

    # use proxy if proxy_url is set
    command << '--http-proxy' << resource[:proxy_url] if resource[:proxy_url] && !resource[:proxy_url].empty?

    list = []
    begin
      list = execute(command).split("\n").map do |line|
        line.strip if line =~ %r{^\s+\S+}
      end.compact
    rescue Puppet::ExecutionFailure => e
      Puppet.debug "`rvmcmd` command failed with #{e}"
    end

    list
  end

  def create
    command = gemsetcommand + ['create', gemset_name]
    execute(command)
  end

  def destroy
    command = gemsetcommand_force + ['delete', gemset_name]
    execute(command)
  end

  def exists?
    gemset_list.include? gemset_name
  end
end
