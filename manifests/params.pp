# == Class opscenter::params
#
# This class is meant to be called from opscenter
# It sets variables according to platform
#
class opscenter::params {
  case $::osfamily {
    'Debian': {
      $systemctl = '/bin/systemctl'
      $systemd_path = '/lib/systemd/system'
    }
    'RedHat': {
      $systemctl = '/usr/bin/systemctl'
      $systemd_path = '/usr/lib/systemd/system'
    }
    default: {
      $config_path_parents = []
    }
  }
}
