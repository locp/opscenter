require 'beaker-rspec'
require 'pry'

hosts.each do |host|
  if host.name =~ /ubuntu.*1604/
    host.install_package('puppet')
  else
    install_puppet_on(host)
  end
end

RSpec.configure do |c|
  module_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module
    puppet_module_install(source: module_root, module_name: 'opscenter')
    hosts.each do |host|
      on host, puppet('module', 'install',
                      'puppetlabs-apt'), acceptable_exit_codes: [0, 1]
      on host, puppet('module', 'install',
                      'puppetlabs-inifile'), acceptable_exit_codes: [0, 1]
      on host, puppet('module', 'install',
                      'puppetlabs-stdlib'), acceptable_exit_codes: [0, 1]
      on host, puppet('module', 'install', '--version', '1.25.2',
                      'locp-cassandra'), acceptable_exit_codes: [0, 1]
    end
  end
end
