# Class: opscenter::pycrypto
# ===========================
#
# Install the pycrypto library which is a
# [requirement](https://docs.datastax.com/en/latest-opsc/opsc/configure/installPycrypto.html)
# if you wish to use encryption for configuration values.  This class is silently ignored
# on non-RedHat families.
#
# Attributes
# ----------
#
# * `manage_epel`
# If set to true, the **epel-release** package will be installed.
# Default value 'false'
#
# * `package_ensure`
# This is passed to the package reference for **pycrypto**.  Valid values are
# **present** or a version number.
# Default value 'present'
#
# * `package_name`
# The name of the PyCrypto package.
# Default value 'pycrypto'
# 
# * `provider`
# The name of the provider of the pycrypto package.
# Default value 'pip'
# 
# * `reqd_pckgs`
# Packages that are required to install the pycrypto package.
# Default value '['python-devel', 'python-pip' ]'
#
# Examples
# --------
#
# @example
#    class { 'opscenter':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class opscenter::pycrypto (
  $manage_epel    = false,
  $package_ensure = 'present',
  $package_name   = 'pycrypto',
  $provider       = 'pip',
  $reqd_pckgs     = ['python-devel', 'python-pip' ],
  ){
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
