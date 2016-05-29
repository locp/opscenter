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
    let :facts do
      {
        osfamily: 'RedHat'
      }
    end

    it do
      should compile
      should contain_class('opscenter')
      should have_resource_count(256)

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

      should contain_opscenter__private__setting('agents agent_certfile')
      should contain_opscenter__private__setting('agents agent_keyfile')
      should contain_opscenter__private__setting('agents agent_keyfile_raw')
      should contain_opscenter__private__setting('agents config_sleep')
      should contain_opscenter__private__setting('agents fingerprint_throttle')
      should contain_opscenter__private__setting('agents incoming_interface')
      should contain_opscenter__private__setting('agents incoming_port')
      should contain_opscenter__private__setting('agents install_throttle')
      should contain_opscenter__private__setting('agents not_seen_threshold')
      should contain_opscenter__private__setting('agents path_to_deb')
      should contain_opscenter__private__setting('agents path_to_find_java')
      should contain_opscenter__private__setting('agents path_to_installscript')
      should contain_opscenter__private__setting('agents path_to_rpm')
      should contain_opscenter__private__setting('agents path_to_sudowrap')
      should contain_opscenter__private__setting('agents reported_interface')
      should contain_opscenter__private__setting('agents runs_sudo')
      should contain_opscenter__private__setting('agents scp_executable')
      should contain_opscenter__private__setting('agents ssh_executable')
      should contain_opscenter__private__setting('agents ssh_keygen_executable')
      should contain_opscenter__private__setting('agents ssh_keyscan_executable')
      should contain_opscenter__private__setting('agents ssh_port')
      should contain_opscenter__private__setting('agents ssh_sys_known_hosts_file')
      should contain_opscenter__private__setting('agents ssh_user_known_hosts_file')
      should contain_opscenter__private__setting('agents ssl_certfile')
      should contain_opscenter__private__setting('agents ssl_keyfile')
      should contain_opscenter__private__setting('agents tmp_dir')
      should contain_opscenter__private__setting('agents use_ssl')
      should contain_opscenter__private__setting('authentication audit_auth')
      should contain_opscenter__private__setting('authentication audit_pattern')
      should contain_opscenter__private__setting('authentication authentication_method')
      should contain_opscenter__private__setting('authentication enabled')
      should contain_opscenter__private__setting('authentication passwd_db')
      should contain_opscenter__private__setting('authentication timeout')
      should contain_opscenter__private__setting('cloud accepted_certs')
      should contain_opscenter__private__setting('clusters add_cluster_timeout')
      should contain_opscenter__private__setting('clusters startup_sleep')
      should contain_opscenter__private__setting('definitions auto_update')
      should contain_opscenter__private__setting('definitions definitions_dir')
      should contain_opscenter__private__setting('definitions download_filename')
      should contain_opscenter__private__setting('definitions download_host')
      should contain_opscenter__private__setting('definitions download_port')
      should contain_opscenter__private__setting('definitions hash_filename')
      should contain_opscenter__private__setting('definitions sleep')
      should contain_opscenter__private__setting('definitions ssl_certfile')
      should contain_opscenter__private__setting('definitions use_ssl')
      should contain_opscenter__private__setting('failover failover_configuration_directory')
      should contain_opscenter__private__setting('failover heartbeat_fail_window')
      should contain_opscenter__private__setting('failover heartbeat_period')
      should contain_opscenter__private__setting('failover heartbeat_reply_period')
      should contain_opscenter__private__setting('hadoop base_job_tracker_proxy_port')
      should contain_opscenter__private__setting('labs orbited_longpoll')
      should contain_opscenter__private__setting('ldap admin_group_name')
      should contain_opscenter__private__setting('ldap connection_timeout')
      should contain_opscenter__private__setting('ldap debug_ssl')
      should contain_opscenter__private__setting('ldap group_name_attribute')
      should contain_opscenter__private__setting('ldap group_search_base')
      should contain_opscenter__private__setting('ldap group_search_filter')
      should contain_opscenter__private__setting('ldap group_search_filter_with_dn')
      should contain_opscenter__private__setting('ldap group_search_type')
      should contain_opscenter__private__setting('ldap ldap_security')
      should contain_opscenter__private__setting('ldap opt_referrals')
      should contain_opscenter__private__setting('ldap protocol_version')
      should contain_opscenter__private__setting('ldap search_dn')
      should contain_opscenter__private__setting('ldap search_password')
      should contain_opscenter__private__setting('ldap server_host')
      should contain_opscenter__private__setting('ldap server_port')
      should contain_opscenter__private__setting('ldap ssl_cacert')
      should contain_opscenter__private__setting('ldap ssl_cert')
      should contain_opscenter__private__setting('ldap ssl_key')
      should contain_opscenter__private__setting('ldap tls_demand')
      should contain_opscenter__private__setting('ldap tls_reqcert')
      should contain_opscenter__private__setting('ldap uri_scheme')
      should contain_opscenter__private__setting('ldap user_memberof_attribute')
      should contain_opscenter__private__setting('ldap user_search_base')
      should contain_opscenter__private__setting('ldap user_search_filter')
      should contain_opscenter__private__setting('logging level')
      should contain_opscenter__private__setting('logging log_length')
      should contain_opscenter__private__setting('logging log_path')
      should contain_opscenter__private__setting('logging max_rotate')
      should contain_opscenter__private__setting('logging resource_usage_interval')
      should contain_opscenter__private__setting('provisioning agent_install_timeout')
      should contain_opscenter__private__setting('provisioning keyspace_timeout')
      should contain_opscenter__private__setting('provisioning private_key_dir')
      should contain_opscenter__private__setting('repair_service alert_on_repair_failure')
      should contain_opscenter__private__setting('repair_service cluster_stabilization_period')
      should contain_opscenter__private__setting('repair_service error_logging_window')
      should contain_opscenter__private__setting('repair_service incremental_err_alert_threshold')
      should contain_opscenter__private__setting('repair_service incremental_range_repair')
      should contain_opscenter__private__setting('repair_service incremental_repair_tables')
      should contain_opscenter__private__setting('repair_service ks_update_period')
      should contain_opscenter__private__setting('repair_service log_directory')
      should contain_opscenter__private__setting('repair_service log_length')
      should contain_opscenter__private__setting('repair_service max_err_threshold')
      should contain_opscenter__private__setting('repair_service max_parallel_repairs')
      should contain_opscenter__private__setting('repair_service max_pending_repairs')
      should contain_opscenter__private__setting('repair_service max_rotate')
      should contain_opscenter__private__setting('repair_service min_repair_time')
      should contain_opscenter__private__setting('repair_service min_throughput')
      should contain_opscenter__private__setting('repair_service num_recent_throughputs')
      should contain_opscenter__private__setting('repair_service persist_directory')
      should contain_opscenter__private__setting('repair_service persist_period')
      should contain_opscenter__private__setting('repair_service restart_period')
      should contain_opscenter__private__setting('repair_service single_repair_timeout')
      should contain_opscenter__private__setting('repair_service single_task_err_threshold')
      should contain_opscenter__private__setting('repair_service snapshot_override')
      should contain_opscenter__private__setting('request_tracker queue_size')
      should contain_opscenter__private__setting('security config_encryption_active')
      should contain_opscenter__private__setting('security config_encryption_key_name')
      should contain_opscenter__private__setting('security config_encryption_key_path')
      should contain_opscenter__private__setting('spark base_master_proxy_port')
      should contain_opscenter__private__setting('stat_reporter initial_sleep')
      should contain_opscenter__private__setting('stat_reporter interval')
      should contain_opscenter__private__setting('stat_reporter report_file')
      should contain_opscenter__private__setting('stat_reporter ssl_key')
      should contain_opscenter__private__setting('ui default_api_timeout')
      should contain_opscenter__private__setting('ui max_metrics_requests')
      should contain_opscenter__private__setting('ui node_detail_refresh_delay')
      should contain_opscenter__private__setting('ui storagemap_ttl')
      should contain_opscenter__private__setting('webserver interface')
      should contain_opscenter__private__setting('webserver log_path')
      should contain_opscenter__private__setting('webserver port')
      should contain_opscenter__private__setting('webserver ssl_certfile')
      should contain_opscenter__private__setting('webserver ssl_keyfile')
      should contain_opscenter__private__setting('webserver ssl_port')
      should contain_opscenter__private__setting('webserver staticdir')
      should contain_opscenter__private__setting('webserver sub_process_timeout')
      should contain_opscenter__private__setting('webserver tarball_process_timeout')
    end
  end

  #  context 'service_provider: init' do
  #    let :facts do
  #      {
  #        osfamily: 'RedHat'
  #      }
  #    end
  #
  #    let :params do
  #      {
  #        service_provider: 'init'
  #      }
  #    end
  #
  #    it do
  #      should compile
  #      should have_resource_count(256)
  #      should contain_service('opscenterd').only_with(
  #        ensure: 'enabled',
  #        name: 'opscenterd',
  #        enable: true
  #      )
  #    end
  #  end

  context 'RedHat, service_systemd: true' do
    let :facts do
      {
        osfamily: 'RedHat'
      }
    end

    let :params do
      {
        service_systemd: true
      }
    end

    it do
      should compile
      should have_resource_count(258)
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
      should have_resource_count(258)
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
