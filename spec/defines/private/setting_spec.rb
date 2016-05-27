require 'spec_helper'
describe 'opscenter::private::setting' do
  let(:pre_condition) do
    [
      'define ini_setting($ensure = nil,
         $path                    = nil,
         $section                 = nil,
         $key_val_separator       = nil,
         $setting                 = nil,
         $value                   = nil) {}'
    ]
  end
end
