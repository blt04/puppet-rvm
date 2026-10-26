# frozen_string_literal: true

Facter.add(:rvm_installed) do
  rvm_binary = '/usr/local/rvm/bin/rvm'

  setcode do
    File.exist? rvm_binary
  end
end
