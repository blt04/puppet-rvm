# RVM gemset support
Puppet::Type.type(:rvm_alias).provide(:alias) do
  desc "RVM alias support."

  commands :rvmcmd => "/usr/local/rvm/bin/rvm"

  def ruby_version
    resource[:ruby_version]
  end

  def alias_name
    resource[:name]
  end

  def aliascmd
    [command(:rvmcmd), "alias"]
  end

  def alias_list
    command = aliascmd + ['list']

    list = []
    begin
      list = execute(command)
    rescue Puppet::ExecutionFailure => detail
    end

    list
  end

  def create
    command = aliascmd + ['create', alias_name, ruby_version]
    execute(command)
  end

  def destroy
    command = aliascmd + ['delete', alias_name]
    execute(command)
  end

  def exists?
    alias_list.include? alias_name
  end
end
