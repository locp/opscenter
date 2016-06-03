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
  settings        => {
    'authentication' => {
      'enabled' => 'False',
    },
    'logging'   => {
      'level' => 'WARN',
    },
    'webserver' => {
      'interface' => '0.0.0.0',
      'port'      => 8888,
    },
  },
  service_systemd => $service_systemd,
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

* [`opscenter`](#class-opscenter): Install and configure DataStax OpsCenter.
* [`opscenter::datastax_repo`](#class-opscenterdatastax_repo): Configure a
  repository for packages to install OpsCenter.
* [`opscenter::pycrypto`](#class-opscenterpycrypto): If you intend to use encryption
  for configuration values, install the pycrypto library. The pycrypto library
  dependency is automatically included in the Debian package install.

### Defined Types

#### Public Defined Types

* [`opscenter::cluster_name`](#defined-type-opscentercluster_name): Configure a cluster to be monitored by
  OpsCenter.

### Attributes

#### Class opscenter

This class installs and manages the DataStax OpsCenter.  Leaving the defaults
as they are will provide a running OpsCenter without any authentication on
port 8888.

##### `config_file`
The full path to the OpsCenter configuration file.
Default value '/etc/opscenter/opscenterd.conf'

##### `config_purge`
Whether to remove cluster configurations that are not controlled by this puppet module.
Valid values are true or false.
Default value false

##### `package_ensure`
This is passed to the package reference for **opscenter**.  Valid values are
**present** or a version number.
Default value 'present'

##### `package_name`
The name of the OpsCenter package.
Default value 'opscenter'

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
* `/lib/systemd/system` on Debian the family.

Default value is false except on RedHat 7 where it is true.

##### `service_systemd_tmpl`
The location for the template for the systemd service file.  This attribute
only has any effect if `service_systemd` is set to true.

Default value `cassandra/opscenterd.service.erb`

##### `settings`
A hash that is passed to
[`create_ini_settings`](https://github.com/puppetlabs/puppetlabs-inifile#manage-multiple-ini_settings)
to set values in `config_file`.  These files need to follow the format specified in
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscConfigProps_r.html .
Default value {} also the settings will have the following defaults:

```puppet
{
  ensure  => present,
  path    => $config_file,
  require => Package['opscenter'],
  notify  => Service['opscenterd'],
}
```

#### Class opscenter::datastax_repo

An optional class that will allow a suitable repository to be configured
from which packages for DataStax Community can be downloaded.  Changing
the defaults will allow any Debian Apt or Red Hat Yum repository to be
configured.

##### `descr`
On the Red Hat family, this is passed as the `descr` attribute to a
`yumrepo` resource.  On the Debian family, it is passed as the `comment`
attribute to an `apt::source` resource.
Default value 'DataStax Repo for Apache Cassandra'

##### `key_id`
On the Debian family, this is passed as the `id` attribute to an `apt::key`
resource.  On the Red Hat family, it is ignored.
Default value '7E41C00F85BFC1706C4FFFB3350200F2B999A372'

##### `key_url`
On the Debian family, this is passed as the `source` attribute to an
`apt::key` resource.  On the Red Hat family, it is ignored.
Default value 'http://debian.datastax.com/debian/repo_key'

##### `pkg_url`
If left as the default, this will set the `baseurl` to
'http://rpm.datastax.com/community' on a `yumrepo` resource
on the Red Hat family.  On the Debian family, leaving this as the default
will set the `location` attribute on an `apt::source` to
'http://debian.datastax.com/community'.  Default value *undef*

##### `release`
On the Debian family, this is passed as the `release` attribute to an
`apt::source` resource.  On the Red Hat family, it is ignored.
Default value 'stable'

#### Class opscenter::pycrypto

On the Red Hat family of operating systems, if one intends to use encryption
for configuration values then the pycrypto library is required.  This class
will install it for the user.  See
http://docs.datastax.com/en/opscenter/5.2//opsc/configure/installPycrypto.html
for more details.

This class has no effect when included on nodes that are not in the Red Hat
family.

##### `manage_epel`
If set to true, the **epel-release** package will be installed.
Default value 'false'

##### `package_ensure`
This is passed to the package reference for **pycrypto**.  Valid values are
**present** or a version number.
Default value 'present'

##### `package_name`
The name of the PyCrypto package.
Default value 'pycrypto'

##### `provider`
The name of the provider of the pycrypto package.
Default value 'pip'

##### `reqd_pckgs`
Packages that are required to install the pycrypto package.
Default value '['python-devel', 'python-pip' ]'

#### Defined Type opscenter::cluster_name

With DataStax Enterprise, one can specify a remote keyspace for OpsCenter
to store metric data (this is not available in the DataStax Community Edition).

##### `cassandra_seed_hosts`
This sets the seed_hosts setting in the cassandra section of the
_cluster_name_.conf configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscStoringCollectionDataDifferentCluster_t.html
for more details.  A value of *undef* will ensure the setting is not
present in the file.  Default value *undef*

##### `config_path`
The path to where OpsCenter stores the cluster configurations.
Default value '/etc/opscenter/clusters'

##### `storage_cassandra_api_port`
This sets the api_port setting in the storage_cassandra section of the
_cluster_name_.conf configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscStoringCollectionDataDifferentCluster_t.html
for more details.  A value of *undef* will ensure the setting is not
present in the file.  Default value *undef*

##### `storage_cassandra_bind_interface`
This sets the bind_interface setting in the storage_cassandra section of the
_cluster_name_.conf configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscStoringCollectionDataDifferentCluster_t.html
for more details.  A value of *undef* will ensure the setting is not
present in the file.  Default value *undef*

##### `storage_cassandra_connection_pool_size`
This sets the connection_pool_size setting in the storage_cassandra section of the
_cluster_name_.conf configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscStoringCollectionDataDifferentCluster_t.html
for more details.  A value of *undef* will ensure the setting is not
present in the file.  Default value *undef*

##### `storage_cassandra_connect_timeout`
This sets the connect_timeout setting in the storage_cassandra section of the
_cluster_name_.conf configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscStoringCollectionDataDifferentCluster_t.html
for more details.  A value of *undef* will ensure the setting is not
present in the file.  Default value *undef*

##### `storage_cassandra_cql_port`
This sets the cql_port setting in the storage_cassandra section of the
_cluster_name_.conf configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscStoringCollectionDataDifferentCluster_t.html
for more details.  A value of *undef* will ensure the setting is not
present in the file.  Default value *undef*

##### `storage_cassandra_keyspace`
This sets the keyspace setting in the storage_cassandra section of the
_cluster_name_.conf configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscStoringCollectionDataDifferentCluster_t.html
for more details.  A value of *undef* will ensure the setting is not
present in the file.  Default value *undef*

##### `storage_cassandra_local_dc_pref`
This sets the local_dc_pref setting in the storage_cassandra section of the
_cluster_name_.conf configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscStoringCollectionDataDifferentCluster_t.html
for more details.  A value of *undef* will ensure the setting is not
present in the file.  Default value *undef*

##### `storage_cassandra_password`
This sets the password setting in the storage_cassandra section of the
_cluster_name_.conf configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscStoringCollectionDataDifferentCluster_t.html
for more details.  A value of *undef* will ensure the setting is not
present in the file.  Default value *undef*

##### `storage_cassandra_retry_delay`
This sets the retry_delay setting in the storage_cassandra section of the
_cluster_name_.conf configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscStoringCollectionDataDifferentCluster_t.html
for more details.  A value of *undef* will ensure the setting is not
present in the file.  Default value *undef*

##### `storage_cassandra_seed_hosts`
This sets the seed_hosts setting in the storage_cassandra section of the
_cluster_name_.conf configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscStoringCollectionDataDifferentCluster_t.html
for more details.  A value of *undef* will ensure the setting is not
present in the file.  Default value *undef*

##### `storage_cassandra_send_rpc`
This sets the send_rpc setting in the storage_cassandra section of the
_cluster_name_.conf configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscStoringCollectionDataDifferentCluster_t.html
for more details.  A value of *undef* will ensure the setting is not
present in the file.  Default value *undef*

##### `storage_cassandra_ssl_ca_certs`
This sets the ssl_ca_certs setting in the storage_cassandra section of the
_cluster_name_.conf configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscStoringCollectionDataDifferentCluster_t.html
for more details.  A value of *undef* will ensure the setting is not
present in the file.  Default value *undef*

##### `storage_cassandra_ssl_client_key`
This sets the ssl_client_key setting in the storage_cassandra section of the
_cluster_name_.conf configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscStoringCollectionDataDifferentCluster_t.html
for more details.  A value of *undef* will ensure the setting is not
present in the file.  Default value *undef*

##### `storage_cassandra_ssl_client_pem`
This sets the ssl_client_pem setting in the storage_cassandra section of the
_cluster_name_.conf configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscStoringCollectionDataDifferentCluster_t.html
for more details.  A value of *undef* will ensure the setting is not
present in the file.  Default value *undef*

##### `storage_cassandra_ssl_validate`
This sets the ssl_validate setting in the storage_cassandra section of the
_cluster_name_.conf configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscStoringCollectionDataDifferentCluster_t.html
for more details.  A value of *undef* will ensure the setting is not
present in the file.  Default value *undef*

##### `storage_cassandra_used_hosts_per_remote_dc`
This sets the used_hosts_per_remote_dc setting in the storage_cassandra section of the
_cluster_name_.conf configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscStoringCollectionDataDifferentCluster_t.html
for more details.  A value of *undef* will ensure the setting is not
present in the file.  Default value *undef*

##### `storage_cassandra_username`
This sets the username setting in the storage_cassandra section of the
_cluster_name_.conf configuration file.  See
http://docs.datastax.com/en/opscenter/5.2/opsc/configure/opscStoringCollectionDataDifferentCluster_t.html
for more details.  A value of *undef* will ensure the setting is not
present in the file.  Default value *undef*

## Development

Contributions will be gratefully accepted.  Please go to the project page,
fork the project, make your changes locally and then raise a pull request.
Details on how to do this are available at
https://guides.github.com/activities/contributing-to-open-source.

### Contributors

Before this project was spun off from
[locp-cassandra](https://forge.puppet.com/locp/cassandra) contributions to how
OpsCenter was configured in that module were made by
[@Mike-Petersen](https://github.com/Mike-Petersen)
and [@jonen10](https://github.com/jonen10).
