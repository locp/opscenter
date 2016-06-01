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

Here, include a complete list of your module's classes, types, providers,
facts, along with the parameters for each. Users refer to this section (thus
the name "Reference") to find specific details; most users don't read it per
se.

## Development

Contributions will be gratefully accepted.  Please go to the project page,
fork the project, make your changes locally and then raise a pull request.
Details on how to do this are available at
https://guides.github.com/activities/contributing-to-open-source.
