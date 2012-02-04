Facter.add(:rvm_installed) do
  setcode do
    result = 'false'
    if File.exist?('/usr/local/rvm/bin/rvm') or File.exist?('/usr/bin/rvm')
      result = 'true'
    end
    result
  end
end

Facter.add(:rvm_binary) do
  confine :rvm_installed => :true
  setcode do
    [ '/usr/local/rvm/bin/rvm', '/usr/bin/rvm' ].each do |binfile|
      if File.exist?(binfile)
        result = binfile
        break
      end
    end
    result
  end
end
