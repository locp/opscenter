require 'spec_helper'

describe 'opscenter::params' do
  context 'with default values for all parameters' do
    let :facts do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: 7
      }
    end

    it do
      should compile
      should contain_class('opscenter::params')
      should have_resource_count(0)
    end
  end
end
