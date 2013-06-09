Puppet::Type.newtype(:rvm_system_ruby) do
  @doc = "Manage RVM Ruby installations."

  ensurable

  newparam(:name) do
    desc "The name of the Ruby to be managed."
    isnamevar
  end

  newproperty(:default_use) do
    desc "Should this Ruby be the system default for new terminals?"
    defaultto false
  end

  newparam(:install_opts) do
    desc "Flags to compile RVM with ie: --with-openssl-dir=..."
    defaultto ""
  end

  newparam(:pkg) do
    desc "install package for this system ruby"
  end
end
