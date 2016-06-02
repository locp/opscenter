# opscenter

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with opscenter](#setup)
    * [Beginning with opscenter](#beginning-with-opscenter)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Development - Guide for contributing to the module](#development)

## Description

[![Coverage Status](https://coveralls.io/repos/github/locp/opscenter/badge.svg?branch=master)](https://coveralls.io/github/locp/opscenter?branch=master)

Installs DataStax OpsCenter on RHEL/Ubuntu/Debian.  This functionality used to be included with the
[locp/cassandra](https://forge.puppet.com/locp/cassandra) Puppet module, but now that DataStax are about to change
their support policy, this functionality has been moved to here.

### Change of DataStax OpsCenter Policy
From
[DataStax OpsCenter Policy Changes](http://docs.datastax.com/en/opscenter/latest/opsc/opscPolicyChanges.html):
> Starting with OpsCenter version 6.0, OpsCenter will only be compatible with DataStax Enterprise (DSE) clusters. DataStax will discontinue OpsCenter compatibility with:
* Open Source Software (OSS) Cassandra clusters
* DataStax Distributions of Cassandra (DDC) clusters, formerly known as DataStax Community (DSC)

> Customers currently using OpsCenter to provision, manage, and maintain their OSS Cassandra, DSC, and DDC clusters must look for other tools to continue their management and maintenance activities. Please see [Planet Cassandra](http://www.planetcassandra.org/related-projects/) for some alternatives.

## Setup

### Beginning with opscenter

```puppet
class { 'opscenter::datastax_repo':
  before => Class['cassandra', 'opscenter'],
}

class { 'opscenter::pycrypto':
  manage_epel => true,
}

class { 'opscenter':
  authentication_enabled => 'True',
  service_systemd        => $service_systemd,
}
```

## Usage

### DataStax Enterprise (DSE)

With DataStax Enterprise (DSE) one can specify a remote keyspace for storing the metrics for
a cluster:

```puppet
opscenter::cluster_name { 'Cluster1':
  cassandra_seed_hosts       => 'host1,host2',
  storage_cassandra_username => 'opsusr',
  storage_cassandra_password => 'opscenter',
  storage_cassandra_api_port => 9160,
  storage_cassandra_cql_port => 9042,
  storage_cassandra_keyspace => 'OpsCenter_Cluster1'
}
```

## Reference

### Classes

#### Public Classes

* [`opscenter`](#opscenter): Install and configure DataStax OpsCenter.
* [`opscenter::datastax_repo`](#opscenterdatastax_repo): Configure a
  repository for packages to install OpsCenter.
* [`opscenter::pycrypto`](#opscenterpycrypto): If you intend to use encryption
  for configuration values, install the pycrypto library. The pycrypto library
  dependency is automatically included in the Debian package install.

### Defined Types

#### Public Defined Types

* opscenter::cluster_name: Configure a cluster to be monitored by OpsCenter.

#### Private Defined Types

* opscenter::private::setting: Set individual settings in the configuration
  file.

### Attributes

#### opscenter

This class installs and manages the DataStax OpsCenter.  Leaving the defaults
as they are will provide a running OpsCenter without any authentication on
port 8888.

#### Attributes

##### `agents_agent_certfile`
This sets the agent_certfile setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_agent_keyfile`
This sets the agent_keyfile setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_agent_keyfile_raw`
This sets the agent_keyfile_raw setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_config_sleep`
This sets the config_sleep setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_fingerprint_throttle`
This sets the fingerprint_throttle setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_incoming_interface`
This sets the incoming_interface setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_incoming_port`
This sets the incoming_port setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_install_throttle`
This sets the install_throttle setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_not_seen_threshold`
This sets the not_seen_threshold setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_path_to_deb`
This sets the path_to_deb setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_path_to_find_java`
This sets the path_to_find_java setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_path_to_installscript`
This sets the path_to_installscript setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_path_to_rpm`
This sets the path_to_rpm setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_path_to_sudowrap`
This sets the path_to_sudowrap setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_reported_interface`
This sets the reported_interface setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_runs_sudo`
This sets the runs_sudo setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_scp_executable`
This sets the scp_executable setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_ssh_executable`
This sets the ssh_executable setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_ssh_keygen_executable`
This sets the ssh_keygen_executable setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_ssh_keyscan_executable`
This sets the ssh_keyscan_executable setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_ssh_port`
This sets the ssh_port setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_ssh_sys_known_hosts_file`
This sets the ssh_sys_known_hosts_file setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_ssh_user_known_hosts_file`
This sets the ssh_user_known_hosts_file setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_ssl_certfile`
This sets the ssl_certfile setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_ssl_keyfile`
This sets the ssl_keyfile setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_tmp_dir`
This sets the tmp_dir setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `agents_use_ssl`
This sets the use_ssl setting in the agents section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `authentication_audit_auth`
This sets the audit_auth setting in the authentication section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `authentication_audit_pattern`
This sets the audit_pattern setting in the authentication section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `authentication_method`
This sets the authentication_method setting in the authentication section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `authentication_enabled`
This sets the enabled setting in the authentication section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value 'False'

##### `authentication_passwd_db`
This sets the passwd_db setting in the authentication section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `authentication_timeout`
This sets the timeout setting in the authentication section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `cloud_accepted_certs`
This sets the accepted_certs setting in the cloud section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `clusters_add_cluster_timeout`
This sets the add_cluster_timeout setting in the clusters section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `clusters_startup_sleep`
This sets the startup_sleep setting in the clusters section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `config_file`
The full path to the OpsCenter configuration file.
Default value '/etc/opscenter/opscenterd.conf'

##### `config_purge`
Whether to remove cluster configurations that are not controlled by this puppet module.
Valid values are true or false.
Default value false

##### `definitions_auto_update`
This sets the auto_update setting in the definitions section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `definitions_definitions_dir`
This sets the definitions_dir setting in the definitions section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `definitions_download_filename`
This sets the download_filename setting in the definitions section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `definitions_download_host`
This sets the download_host setting in the definitions section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `definitions_download_port`
This sets the download_port setting in the definitions section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `definitions_hash_filename`
This sets the hash_filename setting in the definitions section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `definitions_sleep`
This sets the sleep setting in the definitions section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `definitions_ssl_certfile`
This sets the ssl_certfile setting in the definitions section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `definitions_use_ssl`
This sets the use_ssl setting in the definitions section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `failover_configuration_directory`
This sets the failover_configuration_directory setting in the failover section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `failover_heartbeat_fail_window`
This sets the heartbeat_fail_window setting in the failover section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `failover_heartbeat_period`
This sets the heartbeat_period setting in the failover section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `failover_heartbeat_reply_period`
This sets the heartbeat_reply_period setting in the failover section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `hadoop_base_job_tracker_proxy_port`
This sets the base_job_tracker_proxy_port setting in the hadoop section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_admin_group_name`
This sets the admin_group_name setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_connection_timeout`
This sets the connection_timeout setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_debug_ssl`
This sets the debug_ssl setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_group_name_attribute`
This sets the group_name_attribute setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_group_search_base`
This sets the group_search_base setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_group_search_filter`
Is deprecated use `ldap_group_search_filter_with_dn` instead.

This sets the group_search_filter setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_group_search_filter_with_dn`
This sets the group_search_filter_with_dn setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_group_search_type`
This sets the group_search_type setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_ldap_security`
This sets the ldap_security setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_opt_referrals`
This sets the opt_referrals setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_protocol_version`
This sets the protocol_version setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_search_dn`
This sets the search_dn setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_search_password`
This sets the search_password setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_server_host`
This sets the server_host setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_server_port`
This sets the server_port setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_ssl_cacert`
This sets the ssl_cacert setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_ssl_cert`
This sets the ssl_cert setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_ssl_key`
This sets the ssl_key setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_tls_demand`
This sets the tls_demand setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_tls_reqcert`
This sets the tls_reqcert setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_uri_scheme`
This sets the uri_scheme setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_user_memberof_attribute`
This sets the user_memberof_attribute setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_user_search_base`
This sets the user_search_base setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ldap_user_search_filter`
This sets the user_search_filter setting in the ldap section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `logging_level`
This sets the level setting in the logging section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `logging_log_length`
This sets the log_length setting in the logging section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `logging_log_path`
This sets the log_path setting in the logging section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `logging_max_rotate`
This sets the max_rotate setting in the logging section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `logging_resource_usage_interval`
This sets the resource_usage_interval setting in the logging section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `orbited_longpoll`
This sets the orbited_longpoll setting in the labs section of the OpsCenter 
configuration file. See labs http://docs.datastax.com/en/opscenter/5.2/opsc/troubleshooting/opscTroubleshootingZeroNodes.html
for more details.  A value of *undef* will ensure the setting is not present in 
the file. Default value *undef*

##### `package_ensure`
This is passed to the package reference for **opscenter**.  Valid values are
**present** or a version number.
Default value 'present'

##### `package_name`
The name of the OpsCenter package.
Default value 'opscenter'

##### `provisioning_agent_install_timeout`
This sets the agent_install_timeout setting in the provisioning section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `provisioning_keyspace_timeout`
This sets the keyspace_timeout setting in the provisioning section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `provisioning_private_key_dir`
This sets the private_key_dir setting in the provisioning section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `repair_service_alert_on_repair_failure`
This sets the alert_on_repair_failure setting in the repair_service section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `repair_service_cluster_stabilization_period`
This sets the cluster_stabilization_period setting in the repair_service section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `repair_service_error_logging_window`
This sets the error_logging_window setting in the repair_service section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `repair_service_incremental_err_alert_threshold`
This sets the incremental_err_alert_threshold setting in the repair_service section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `repair_service_incremental_range_repair`
This sets the incremental_range_repair setting in the repair_service section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `repair_service_incremental_repair_tables`
This sets the incremental_repair_tables setting in the repair_service section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `repair_service_ks_update_period`
This sets the ks_update_period setting in the repair_service section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `repair_service_log_directory`
This sets the log_directory setting in the repair_service section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `repair_service_log_length`
This sets the log_length setting in the repair_service section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `repair_service_max_err_threshold`
This sets the max_err_threshold setting in the repair_service section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `repair_service_max_parallel_repairs`
This sets the max_parallel_repairs setting in the repair_service section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `repair_service_max_pending_repairs`
This sets the max_pending_repairs setting in the repair_service section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `repair_service_max_rotate`
This sets the max_rotate setting in the repair_service section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `repair_service_min_repair_time`
This sets the min_repair_time setting in the repair_service section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `repair_service_min_throughput`
This sets the min_throughput setting in the repair_service section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `repair_service_num_recent_throughputs`
This sets the num_recent_throughputs setting in the repair_service section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `repair_service_persist_directory`
This sets the persist_directory setting in the repair_service section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `repair_service_persist_period`
This sets the persist_period setting in the repair_service section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `repair_service_restart_period`
This sets the restart_period setting in the repair_service section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `repair_service_single_repair_timeout`
This sets the single_repair_timeout setting in the repair_service section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `repair_service_single_task_err_threshold`
This sets the single_task_err_threshold setting in the repair_service section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `repair_service_snapshot_override`
This sets the snapshot_override setting in the repair_service section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `request_tracker_queue_size`
This sets the queue_size setting in the request_tracker section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `security_config_encryption_active`
This sets the config_encryption_active setting in the security section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `security_config_encryption_key_name`
This sets the config_encryption_key_name setting in the security section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `security_config_encryption_key_path`
This sets the config_encryption_key_path setting in the security section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `service_enable`
Enable the OpsCenter service to start at boot time.  Valid values are true
or false.
Default value 'true'

##### `service_ensure`
Ensure the OpsCenter service is running.  Valid values are running or stopped.
Default value 'running'

##### `service_name`
The name of the service that runs the OpsCenter software.
Default value 'opscenterd'

##### `service_provider`
The name of the provider that runs the service.  If left as *undef* then the OS family specific default will
be used, otherwise the specified value will be used instead.
Default value *undef*

##### `service_systemd`
If set to true then a systemd service file called 
${*systemd_path*}/${*service_name*}.service will be added to the node with
basic settings to ensure that the Cassandra service interacts with systemd
better where *systemd_path* will be:

* `/usr/lib/systemd/system` on the Red Hat family.
* `/lib/systemd/system` on Debian the familiy.

Default value false

##### `service_systemd_tmpl`
The location for the template for the systemd service file.  This attribute
only has any effect if `service_systemd` is set to true.

Default value `cassandra/opscenterd.service.erb`

##### `spark_base_master_proxy_port`
This sets the base_master_proxy_port setting in the spark section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `stat_reporter_initial_sleep`
This sets the initial_sleep setting in the stat_reporter section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `stat_reporter_interval`
This sets the interval setting in the stat_reporter section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `stat_reporter_report_file`
This sets the report_file setting in the stat_reporter section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `stat_reporter_ssl_key`
This sets the ssl_key setting in the stat_reporter section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ui_default_api_timeout`
This sets the default_api_timeout setting in the ui section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ui_max_metrics_requests`
This sets the max_metrics_requests setting in the ui section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ui_node_detail_refresh_delay`
This sets the node_detail_refresh_delay setting in the ui section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `ui_storagemap_ttl`
This sets the storagemap_ttl setting in the ui section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `webserver_interface`
This sets the interface setting in the webserver section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value '0.0.0.0'

##### `webserver_log_path`
This sets the log_path setting in the webserver section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `webserver_port`
This sets the port setting in the webserver section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value '8888'

##### `webserver_ssl_certfile`
This sets the ssl_certfile setting in the webserver section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `webserver_ssl_keyfile`
This sets the ssl_keyfile setting in the webserver section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `webserver_ssl_port`
This sets the ssl_port setting in the webserver section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `webserver_staticdir`
This sets the staticdir setting in the webserver section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `webserver_sub_process_timeout`
This sets the sub_process_timeout setting in the webserver section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

##### `webserver_tarball_process_timeout`
This sets the tarball_process_timeout setting in the webserver section of the
OpsCenter configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html
for more details.  A value of *undef* will ensure the setting is not present
in the file.  Default value *undef*

#### opscenter::datastax_repo

#### opscenter::pycrypto

## Development

Contributions will be gratefully accepted.  Please go to the project page,
fork the project, make your changes locally and then raise a pull request.
Details on how to do this are available at
https://guides.github.com/activities/contributing-to-open-source.
