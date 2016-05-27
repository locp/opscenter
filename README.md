# opscenter

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with opscenter](#setup)
    * [What opscenter affects](#what-opscenter-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with opscenter](#beginning-with-opscenter)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description
Installs DataStax OpsCenter on RHEL/Ubuntu/Debian.  This functionality used to be included with the
[locp/cassandra](https://forge.puppet.com/locp/cassandra) Puppet module, but now that DataStax are about to change
their support policy, this functionality has been moved to here.

> Starting with OpsCenter version 6.0, OpsCenter will only be compatible with DataStax Enterprise (DSE) clusters. DataStax will discontinue OpsCenter compatibility with:
* Open Source Software (OSS) Cassandra clusters
* DataStax Distributions of Cassandra (DDC) clusters, formerly known as DataStax Community (DSC)

Customers currently using OpsCenter to provision, manage, and maintain their OSS Cassandra, DSC, and DDC clusters must look for other tools to continue their management and maintenance activities. Please see [Planet Cassandra](http://www.planetcassandra.org/related-projects/) for some alternatives.

[DataStax OpsCenter Policy Changes](http://docs.datastax.com/en/opscenter/latest/opsc/opscPolicyChanges.html)

Start with a one- or two-sentence summary of what the module does and/or what
problem it solves. This is your 30-second elevator pitch for your module.
Consider including OS/Puppet version it works with.

You can give more descriptive information in a second paragraph. This paragraph
should answer the questions: "What does this module *do*?" and "Why would I use
it?" If your module has a range of functionality (installation, configuration,
management, etc.), this is the time to mention it.

## Setup

### What opscenter affects **OPTIONAL**

If it's obvious what your module touches, you can skip this section. For
example, folks can probably figure out that your mysql_instance module affects
their MySQL instances.

If there's more that they should know about, though, this is the place to mention:

* A list of files, packages, services, or operations that the module will alter,
  impact, or execute.
* Dependencies that your module automatically installs.
* Warnings or other important notices.

### Setup Requirements **OPTIONAL**

If your module requires anything extra before setting up (pluginsync enabled,
etc.), mention it here.

If your most recent release breaks compatibility or requires particular steps
for upgrading, you might want to include an additional "Upgrading" section
here.

### Beginning with opscenter

The very basic steps needed for a user to get the module up and running. This
can include setup steps, if necessary, or it can be an example of the most
basic use of the module.

## Usage

This section is where you describe how to customize, configure, and do the
fancy stuff with your module here. It's especially helpful if you include usage
examples and code samples for doing things with your module.

## Reference

Here, include a complete list of your module's classes, types, providers,
facts, along with the parameters for each. Users refer to this section (thus
the name "Reference") to find specific details; most users don't read it per
se.

## Limitations

This is where you list OS compatibility, version compatibility, etc. If there
are Known Issues, you might want to include them under their own heading here.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You can also add any additional sections you feel
are necessary or important to include here. Please use the `## ` header.
