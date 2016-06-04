# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
# Learn more about module testing here:
# https://docs.puppet.com/guides/tests_smoke.html
#
class { 'opscenter::datastax_repo':
  before => Class['opscenter'],
}

class { 'opscenter::pycrypto':
  manage_epel => true,
}

class { 'opscenter':
  settings  => {
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
}

opscenter::cluster_name { 'Cluster1':
  settings => {
    'cassandra' => {
      'seed_hosts' => 'localhost',
    },
  },
}
