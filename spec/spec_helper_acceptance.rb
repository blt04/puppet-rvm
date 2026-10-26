# frozen_string_literal: true

require 'voxpupuli/acceptance/spec_helper_acceptance'

configure_beaker do |host|
  install_puppet_module_via_pmt_on(host, 'puppet-epel') if fact_on(host, 'os.family') == 'RedHat'
  install_puppet_module_via_pmt_on(host, 'puppetlabs-apache')
  install_puppet_module_via_pmt_on(host, 'puppetlabs-java')
end
