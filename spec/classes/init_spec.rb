require 'spec_helper'
describe 'opscenter' do
  let(:pre_condition) do
    [
      'define ini_setting ($ensure = nil,
        $path,
        $section,
        $key_val_separator = nil,
        $setting,
        $value = nil) {}'
    ]
  end

  context 'with default values for all parameters' do
    it do
      should compile
      should contain_class('opscenter')
    end
  end
end
