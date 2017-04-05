# Change Log

##2017-04-05 - Release 2.0.9 ([diff](https://github.com/locp/opscenter/compare/2.0.8...2.0.9))

### Summary

Hotfix to remedy build failures.

#### Bugfix
* Rubocop errors (see #16).
* Puppet metadata errors (see #17).

##2016-12-03 - Release 2.0.8 ([diff](https://github.com/locp/opscenter/compare/2.0.7...2.0.8))

### Summary

#### Bugfix
* Fixed a problem that was showing the master build as failed.

##2016-12-02 - Release 2.0.7 ([diff](https://github.com/locp/opscenter/compare/2.0.5...2.0.7))

### Summary

#### Bugfix
* Rubocop appeasement since upgrade of that gem to 0.46.0.

##2016-10-01 - Release 2.0.5 ([diff](https://github.com/locp/opscenter/compare/2.0.4...2.0.5))

### Summary
Fixed automated acceptance tests now that `locp-cassandra` 2.0.0 has been released.

##2016-07-20 - Release 2.0.4 ([diff](https://github.com/locp/opscenter/compare/2.0.3...2.0.4))

### Summary
A non-functional improvement.  We now test against Ubuntu 16.04.

##2016-07-09 - Release 2.0.3 ([diff](https://github.com/locp/opscenter/compare/2.0.2...2.0.3))

### Summary
Removed puppetlabs-firewall dependency as it is not required.

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
