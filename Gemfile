source ENV['GEM_SOURCE'] || 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'] : ['>= 3.3']

gem 'coveralls',
    require: false
gem 'facter',
    '>= 1.7.0'
gem 'metadata-json-lint'
gem 'puppet',
    puppetversion
gem 'puppetlabs_spec_helper',
    '>= 1.0.0'
gem 'puppet-lint',
    '>= 1.0.0'
gem 'puppet-strings'
gem 'rspec_junit_formatter',
    '0.2.2'
gem 'rspec-puppet'
gem 'simplecov',
    require: false,
    group: :test
gem 'yard'

# rspec must be v2 for ruby 1.8.7
if RUBY_VERSION >= '1.8.7' && RUBY_VERSION < '1.9'
  gem 'rspec', '~> 2.0'
  gem 'rake',  '~> 10.0'
else
  # rubocop requires ruby >= 1.9
  gem 'rubocop'
end
