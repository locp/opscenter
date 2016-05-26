require 'spec_helper'
describe 'opscenter' do
  context 'with default values for all parameters' do
    it { should contain_class('opscenter') }
  end
end
