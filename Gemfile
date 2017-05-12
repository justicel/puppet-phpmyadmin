source ENV['GEM_SOURCE'] || 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'] : ['4.6.1']
gem 'puppet', puppetversion, require: false

group :rubobop do
  gem 'rubocop', '~> 0.47.0',       require: false
  gem 'rubocop-rspec', '~> 1.10.0', require: false
end

group :testing do
  gem 'metadata-json-lint',     require: false
  gem 'puppetlabs_spec_helper', '1.2.2'
  gem 'rake', '11.3.0'
  gem 'rspec-puppet',           require: false
  gem 'rspec-puppet-facts',     require: false
end

group :acceptance do
  gem 'beaker-rspec', '5.6.0'
  gem 'serverspec',   require: false
  gem 'specinfra',    require: false
end
