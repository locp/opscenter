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

  let!(:stdlib_stubs) do
    MockFunction.new('create_ini_settings') do |_f|
    end
  end

  context 'with default values for all parameters' do
    let :facts do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: 7
      }
    end

    it do
      should compile
      should contain_class('opscenter')
      should have_resource_count(4)

      should contain_package('opscenter').only_with(
        ensure: 'present',
        name: 'opscenter',
        before: 'Service[opscenterd]'
      )

      should contain_service('opscenterd').only_with(
        ensure: 'running',
        name: 'opscenterd',
        enable: true
      )
    end
  end

  context 'with default values for all parameters' do
    let :facts do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: 6
      }
    end

    it do
      should have_resource_count(2)
    end
  end

  context 'RedHat, service_systemd: true' do
    let :facts do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: 7
      }
    end

    it do
      should compile
      should have_resource_count(4)
      should contain_exec('opscenter_reload_systemctl').only_with(
        command: '/usr/bin/systemctl daemon-reload',
        refreshonly: true,
        notify: 'Service[opscenterd]'
      )
      should contain_file('/usr/lib/systemd/system/opscenterd.service').with(
        ensure: 'present',
        owner: 'root',
        group: 'root',
        mode: '0644',
        before: 'Package[opscenter]',
        notify: 'Exec[opscenter_reload_systemctl]'
      )
    end
  end

  context 'Debian, service_systemd: true' do
    let :facts do
      {
        osfamily: 'Debian'
      }
    end
    let :params do
      {
        service_systemd: true
      }
    end

    it do
      should compile
      should have_resource_count(4)
      should contain_exec('opscenter_reload_systemctl').only_with(
        command: '/bin/systemctl daemon-reload',
        refreshonly: true,
        notify: 'Service[opscenterd]'
      )
      should contain_file('/lib/systemd/system/opscenterd.service').with(
        ensure: 'present',
        owner: 'root',
        group: 'root',
        mode: '0644',
        before: 'Package[opscenter]',
        notify: 'Exec[opscenter_reload_systemctl]'
      )
    end
  end
end
