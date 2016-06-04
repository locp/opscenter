require 'spec_helper'
describe 'opscenter::cluster_name' do
  let!(:stdlib_stubs) do
    MockFunction.new('create_ini_settings') do |_f|
    end
  end

  context 'defaults' do
    let(:title) { 'MyCluster' }

    let :facts do
      {
        osfamily: 'RedHat',
        operatingsystemmajrelease: 6
      }
    end

    it do
      should have_resource_count(5)

      should contain_file('/etc/opscenter/clusters').with(
        ensure: 'directory',
        purge: false,
        recurse: false,
        require: 'Package[opscenter]'
      )

      should contain_file('opscenter: MyCluster').with(
        ensure: 'present',
        path: '/etc/opscenter/clusters/MyCluster.conf',
        mode: '0644',
        require: 'Package[opscenter]'
      )
    end
  end
end
