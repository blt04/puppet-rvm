Puppet::Type.newtype(:rvm_alias) do
  @doc = "Manage RVM Aliases."

  #def self.title_patterns
  #  [ [ /^(?:(.*)@)?(.*)$/, [ [ :ruby_version, lambda{|x| x} ], [ :name, lambda{|x| x} ] ] ] ]
  #end

  ensurable

  newparam(:name) do
    desc "The name of the alias to be managed."
    isnamevar
  end

  newparam(:ruby_version) do
    desc "The ruby version that is the target of our alias.  This should be the fully qualified RVM string.
    For example: 'ruby-1.9.2-p290'
    For a full list of known strings: `rvm list known_strings`."
  end

end
