# frozen_string_literal: true

require 'puppet/provider/package'
require 'uri'

# Ruby gems support.
Puppet::Type.type(:rvm_gem).provide(:gem) do
  desc 'Ruby Gem support using RVM.'

  has_feature :versionable
  has_command(:rvmcmd, '/usr/local/rvm/bin/rvm') do
    environment HOME: ENV.fetch('HOME', nil)
  end

  def ruby_version
    resource[:ruby_version]
  end

  def rubygems_version
    command = gembinary + ['-v']
    execute(command)
  end

  def gembinary
    [command(:rvmcmd), ruby_version, 'do', 'gem']
  end

  def gemlist(hash)
    command = gembinary + ['list']

    command << if hash[:local]
                 '--local'
               else
                 '--remote'
               end

    if (name = hash[:justme])
      command << "^#{name}$"
    end

    # use proxy if proxy_url is set
    command << '--http-proxy' << resource[:proxy_url] if resource[:proxy_url] && !resource[:proxy_url].empty?

    list = []
    begin
      list = execute(command).split("\n").map do |set|
        if (gemhash = self.class.gemsplit(set))
          gemhash[:provider] = :gem
          gemhash
        end
      end.compact
    rescue Puppet::ExecutionFailure => e
      Puppet.debug "`rvmcmd` command failed with #{e}"
    end

    return list.shift if hash[:justme]

    list
  end

  def self.gemsplit(desc)
    desc = desc.gsub('default: ', '')

    case desc
    when %r{^\*\*\*}, %r{^\s*$}, %r{^\s+} then nil
    when %r{gem: not found} then nil # rubocop:disable Lint/DuplicateBranch
    when %r{^(\S+)\s+\((\d+.*)\)}
      name = Regexp.last_match(1)
      version = Regexp.last_match(2).split(%r{,\s*})
      {
        name: name,
        ensure: version,
      }
    else
      Puppet.warning "Could not match #{desc}"
      nil
    end
  end

  def install(useversion = true)
    command = gembinary + ['install']
    command << '-v' << resource[:ensure] if (!resource[:ensure].is_a? Symbol) && useversion
    # Dependencies are now installed by default
    # command << "--include-dependencies"

    # use proxy if proxy_url is set
    command << '--http-proxy' << resource[:proxy_url] if resource[:proxy_url] && !resource[:proxy_url].empty?

    if (source = resource[:source])
      begin
        uri = URI.parse(source)
      rescue StandardError => e
        raise "Invalid source '#{uri}': #{e}"
      end

      case uri.scheme
      when nil
        # no URI scheme => interpret the source as a local file
        command << source
      when %r{file}i
        command << uri.path
      when 'puppet'
        # we don't support puppet:// URLs (yet)
        raise Puppet::Error, 'puppet:// URLs are not supported as gem sources'
      else
        # interpret it as a gem repository
        command << '--source' << source.to_s << resource[:name]
      end
    elsif Gem::Version.new(rubygems_version) < Gem::Version.new('3.0.0')
      command << '--no-rdoc' << '--no-ri' << resource[:name] # Deprecated options (backwards compatible)
    else
      command << '--no-document' << resource[:name]
    end

    # makefile opts,
    # must be last
    command << '--' << resource[:withopts] if resource[:withopts]

    output = execute(command)
    # Apparently some stupid gem versions don't exit non-0 on failure
    raise "Could not install: #{output.chomp}" if output.include?('ERROR')
  end

  def latest
    # This always gets the latest version available.
    hash = gemlist(justme: resource[:name])

    hash[:ensure][0]
  end

  def query
    gemlist(justme: resource[:name], local: true)
  end

  def uninstall
    execute(gembinary + ['uninstall', '-x', '-a', resource[:name]])
  end

  def update
    install(false)
  end
end
