# == Class opscenter::params
#
# This class is meant to be called from opscenter
# It sets variables according to platform
#
class opscenter::params {
  case $::osfamily {
    'Debian': {
      $service_systemd = false
      $systemctl = '/bin/systemctl'
      $systemd_path = '/lib/systemd/system'
    }
    'RedHat': {
      $systemctl = '/usr/bin/systemctl'
      $systemd_path = '/usr/lib/systemd/system'

      case $::operatingsystemmajrelease {
        7: {
            $service_systemd = true
        }
        default: {
            $service_systemd = false
        }
      }
    }
    default: {
      $config_path_parents = []
    }
  }
}
