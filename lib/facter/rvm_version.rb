# frozen_string_literal: true

Facter.add(:rvm_version) do
  rvm_binary = '/usr/local/rvm/bin/rvm'

  setcode do
    File.exist?(rvm_binary) ? `#{rvm_binary} version`.strip.match(%r{rvm ([0-9]+\.[0-9]+\.[0-9]+)(?:-next)? .*})[1] : nil
  end
end
