# Class: opscenter::pycrypto
# ===========================
class opscenter::pycrypto (
  $manage_epel    = false,
  $package_ensure = 'present',
  $package_name   = 'pycrypto',
  $provider       = 'pip',
  $reqd_pckgs     = ['python-devel', 'python-pip' ],
  ){
  include opscenter

  if $::osfamily == 'RedHat' {
    if $manage_epel {
      package { 'epel-release':
        ensure => present,
        before => Package[ $reqd_pckgs ],
      }
    }

    package { $reqd_pckgs:
      ensure => present,
      before => Package[$package_name],
    }

    ##########################################################################
    # Nasty hack to workaround PUP-3829.  Hopefully can be removed in the
    # not too distant future.
    file { '/usr/bin/pip-python':
      ensure  => link,
      target  => '/usr/bin/pip',
      require => Package['python-pip'],
      before  => Package[$package_name],
    }
    # End of PUP-3829 hack.
    ##########################################################################

    package { $package_name:
      ensure   => $package_ensure,
      provider => $provider,
      before   => Package['opscenter'],
    }
  }
}
