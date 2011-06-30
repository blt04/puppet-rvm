Facter.add("rvm_installed") do
  rvm_binary = "/usr/local/bin/rvm"

  setcode do
    File.exists? rvm_binary
  end
end
