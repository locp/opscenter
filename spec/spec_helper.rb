require 'coveralls'
require 'puppetlabs_spec_helper/module_spec_helper'
require 'simplecov'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.minimum_coverage 100
Coveralls.wear!
at_exit { RSpec::Puppet::Coverage.report! }
