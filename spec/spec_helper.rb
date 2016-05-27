require 'coveralls'
require 'puppetlabs_spec_helper/module_spec_helper'

Coveralls.wear!
at_exit { RSpec::Puppet::Coverage.report! }
