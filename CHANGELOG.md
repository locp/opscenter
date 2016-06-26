# Change Log

##2016-06-26 - Release 2.0.2 ([diff](https://github.com/locp/opscenter/compare/2.0.1...2.0.2))

### Summary
Minor bugfix after the new version of RuboCop picked up formatting issues in Vagrantfile.

##2016-06-06 - Release 2.0.1 ([diff](https://github.com/locp/opscenter/compare/2.0.0...2.0.1))

### Summary
Minor bugfix for the puppetlabs-inifile version and fixed some typos in the README.

##2016-06-03 - Release 2.0.0 ([diff](https://github.com/locp/opscenter/compare/1.0.0...2.0.0))

### Summary
Note that this is an update of the major release number, please see the notes on
[Upgrading](https://forge.puppet.com/locp/opscenter#Upgrading).


### Features
* A radical overhaul of the API making it more flexible/powerful.
* Automatically set `service_systemd` to a suitable value.

### Bugfixes
* Corrected typos in the change log.

##2016-06-03 - Release 1.0.0 ([diff](https://github.com/locp/opscenter/compare/0.1.2...1.0.0))

Bumping version from 0.1.2 to 1.0.0.  The API of this module is now the same as the
OpsCenter related classes of version 1.24.0
[locp-cassandra](https://forge.puppet.com/locp/cassandra) and is passing all the unit and
acceptance tests as expected.

##2016-06-03 - Release 0.1.2 ([diff](https://github.com/locp/opscenter/compare/0.1.1...0.1.2))

### Summary

A non-functional release.

### Improvements

* A full suite of acceptance/beaker tests.
* Code refactoring.

##2016-06-02 - Release 0.1.1 ([diff](https://github.com/locp/opscenter/compare/0.1.0...0.1.1))

### Summary

Fixed a problem with automatic deployments to Puppet Forge from CircleCI.

##2016-06-02 - Release 0.1.0

### Summary

Initial release. This functionality used to be included with the
[locp-cassandra](https://forge.puppet.com/locp/cassandra)
but now that DataStax are about to change their
[support policy](http://docs.datastax.com/en/opscenter/latest/opsc/opscPolicyChanges.html),
this functionality has been moved to here.
