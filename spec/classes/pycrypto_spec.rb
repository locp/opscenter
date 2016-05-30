require 'spec_helper'

describe 'opscenter::pycrypto' do
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

  context 'RedHat with default values for all parameters' do
    let :facts do
      {
        osfamily: 'RedHat'
      }
    end

    it do
      should compile
      should contain_class('opscenter::pycrypto')
      should have_resource_count(260)
      should contain_file('/usr/bin/pip-python').with(
        ensure: 'link',
        target: '/usr/bin/pip',
        require: 'Package[python-pip]',
        before: 'Package[pycrypto]'
      )
      should contain_package('pycrypto')
        .with(
          ensure: 'present',
          provider: 'pip'
        )
        .that_comes_before('Package[opscenter]')
      should contain_package('python-devel')
        .with(
          ensure: 'present',
          before: 'Package[pycrypto]'
        )
      should contain_package('python-pip')
        .with(
          ensure: 'present',
          before: 'Package[pycrypto]'
        )
    end
  end

  context 'RedHat, manage_epel: true' do
    let :facts do
      {
        osfamily: 'RedHat'
      }
    end
    let :params do
      {
        manage_epel: true
      }
    end

    it do
      should compile
      should contain_class('opscenter::pycrypto')
      should have_resource_count(261)
      should contain_package('epel-release')
        .with(ensure: 'present')
        .that_comes_before('Package[python-devel]')
        .that_comes_before('Package[python-pip]')
    end
  end

  context 'Debian with default values for all parameters' do
    let :facts do
      {
        osfamily: 'Debian'
      }
    end

    it do
      should compile
      should contain_class('opscenter::pycrypto')
      should have_resource_count(256)
    end
  end
end
