source ENV['GEM_SOURCE'] || 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'] : ['>= 3.3', '< 5.0']

gem 'beaker',
    '2.33.0'
gem 'beaker-rspec'
gem 'coveralls',
    require: false
gem 'facter',
    '>= 1.7.0'
gem 'metadata-json-lint'
gem 'pry'
gem 'puppet',
    puppetversion
gem 'puppet-blacksmith'
gem 'puppet-lint',
    '>= 1.0.0'
gem 'puppetlabs_spec_helper',
    '>= 1.0.0'
gem 'rspec-puppet'
gem 'rspec-puppet-utils'
gem 'rspec_junit_formatter',
    '0.2.2'
gem 'simplecov',
    require: false,
    group: :test

# rspec must be v2 for ruby 1.8.7
if RUBY_VERSION >= '1.8.7' && RUBY_VERSION < '1.9'
  gem 'rake',  '~> 10.0'
  gem 'rspec', '~> 2.0'
else
  # rubocop requires ruby >= 1.9
  gem 'rubocop', '< 0.50'
end
