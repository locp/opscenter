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
    let(:title) { 'MyCluster' }

    let :facts do
      {
        osfamily: 'RedHat'
      }
    end

    let :params do
      {
        cassandra_seed_hosts: '192.168.0.42',
        storage_cassandra_keyspace: 'MyCluster_opc_keyspace',
        storage_cassandra_seed_hosts: 'host1,host2'
      }
    end

    it do
      should compile
      should contain_file('/etc/opscenter/clusters').with(
        ensure: 'directory',
        purge: false,
        recurse: false,
        require: 'Package[opscenter]'
      )
      should contain_file('/etc/opscenter/clusters/MyCluster.conf').with(
        ensure: 'present',
        mode: '0644',
        require: 'Package[opscenter]'
      )
      should contain_ini_setting('MyCluster:cassandra_seed_hosts').with(
        ensure: 'present',
        section: 'cassandra',
        setting: 'seed_hosts',
        value: '192.168.0.42',
        path: '/etc/opscenter/clusters/MyCluster.conf'
      )
      should contain_ini_setting('MyCluster:storage_cassandra_api_port').with('ensure' => 'absent')
      should contain_ini_setting('MyCluster:storage_cassandra_bind_interface').with('ensure' => 'absent')
      should contain_ini_setting('MyCluster:storage_cassandra_connection_pool_size').with('ensure' => 'absent')
      should contain_ini_setting('MyCluster:storage_cassandra_connect_timeout').with('ensure' => 'absent')
      should contain_ini_setting('MyCluster:storage_cassandra_cql_port').with('ensure' => 'absent')
      should contain_ini_setting('MyCluster:storage_cassandra_keyspace')
        .with(
          ensure: 'present',
          section: 'storage_cassandra',
          setting: 'keyspace',
          value: 'MyCluster_opc_keyspace'
        )
      should contain_ini_setting('MyCluster:storage_cassandra_local_dc_pref').with('ensure' => 'absent')
      should contain_ini_setting('MyCluster:storage_cassandra_password').with('ensure' => 'absent')
      should contain_ini_setting('MyCluster:storage_cassandra_retry_delay').with('ensure' => 'absent')
      should contain_ini_setting('MyCluster:storage_cassandra_seed_hosts')
        .with(
          ensure: 'present',
          section: 'storage_cassandra',
          setting: 'seed_hosts',
          value: 'host1,host2'
        )
      should contain_ini_setting('MyCluster:storage_cassandra_send_rpc').with('ensure' => 'absent')
      should contain_ini_setting('MyCluster:storage_cassandra_ssl_ca_certs').with('ensure' => 'absent')
      should contain_ini_setting('MyCluster:storage_cassandra_ssl_client_key').with('ensure'  => 'absent')
      should contain_ini_setting('MyCluster:storage_cassandra_ssl_client_pem').with('ensure'  => 'absent')
      should contain_ini_setting('MyCluster:storage_cassandra_ssl_validate').with('ensure' => 'absent')
      should contain_ini_setting('MyCluster:storage_cassandra_used_hosts_per_remote_dc').with('ensure' => 'absent')
      should contain_ini_setting('MyCluster:storage_cassandra_username').with('ensure' => 'absent')
    end
  end
end
