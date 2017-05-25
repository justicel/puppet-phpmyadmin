require 'puppet'
require 'beaker-rspec'
require 'yaml'

install_puppet_agent_on hosts, {}

def copy_hiera_files_to(host, opts = {})
  scp_to host, opts[:hiera_yaml], opts[:target] + '/hiera.yaml'
end

RSpec.configure do |c|
  # Module root and settings
  module_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  module_name = module_root.split('/').last.split('-').last

  c.formatter = :documentation
  c.max_displayed_failure_line_count = 5

  c.before :suite do
    puts 'Install module and dependencies'
    puppet_module_install(source: module_root, module_name: module_name)
    modules_fixtures = YAML.load_file(module_root + '/.fixtures.yml')
    modules = modules_fixtures['fixtures']['repositories']

    hosts.each do |host|
      puts 'Copy hiera.yaml for Beaker'
      copy_hiera_files_to(host,
                          hiera_yaml: module_root + '/spec/hiera/hiera.yaml.beaker',
                          target: '/etc/puppetlabs/code/modules/' + module_name + '/')

      puts 'Install fixtures'
      modules.each do |mod_name, mod_info|
        url = mod_info['repo']
        ref = mod_info['ref']
        dir = '/etc/puppetlabs/code/environments/production/modules/' + mod_name

        puts format(' - Fetch %s with %s from %s', mod_name, ref, url)
        git_clone = format('git clone %s %s', url, dir)
        git_checkout = format('cd %s && git checkout %s', dir, ref)

        on host, git_clone
        on host, git_checkout
      end
    end
  end
end
