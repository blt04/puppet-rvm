Puppet::Type.type(:rvm_system_ruby).provide(:rvm) do
  desc "Ruby RVM support."

  commands :rvmcmd => "/usr/local/rvm/bin/rvm"

  def create
    rvmcmd "install", resource[:name]
  end

  def destroy
    rvmcmd "uninstall", resource[:name]
  end

  def exists?
    begin
      rvmcmd("list", "strings").split("\n").any? do |line|
        line =~ Regexp.new(Regexp.escape(resource[:name]))
      end
    rescue Puppet::ExecutionFailure => detail
      raise Puppet::Error, "Could not list RVMs: #{detail}"
    end

  end

  def default_use
    begin
      rvmcmd("list", "default", "string").split("\n").any? do |line|
        line =~ Regexp.new(Regexp.escape(resource[:name]))
      end
    rescue Puppet::ExecutionFailure => detail
      raise Puppet::Error, "Could not list default RVM: #{detail}"
    end
  end

  def default_use=(value)
    rvmcmd "--default", "use", resource[:name] if value
  end
end
