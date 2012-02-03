Facter.add("rvm_installed") do
  setcode do
    result = 'false'
    if File.exist?('/usr/local/rvm/bin/rvm') or File.exist?('/usr/bin/rvm')
      result = 'true'
    end
    result
  end
end
