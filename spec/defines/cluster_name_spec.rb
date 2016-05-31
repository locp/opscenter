require 'spec_helper'
describe 'opscenter::cluster_name' do
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

  context 'cassandra_seed_hosts: 192.168.0.42' do
    let(:title) { 'TestCluster' }

    let :facts do
      {
        osfamily: 'RedHat'
      }
    end

    let :params do
      {
        cassandra_seed_hosts: '192.168.0.42'
      }
    end

    it do
      should compile
    end
    it do
      should contain_file('/etc/opscenter/clusters').only_with(
        ensure: 'directory',
        purge: true,
        recurse: true,
        require: 'Package[opscenter]'
      )
    end
  end
end
