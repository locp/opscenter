# Class: opscenter
# ===========================
# Install and configure DataStax OpsCenter
class opscenter (
    $config_file          = '/etc/opscenter/opscenterd.conf',
    $config_purge         = false,
    $package_ensure       = present,
    $package_name         = 'opscenter',
    $service_enable       = true,
    $service_ensure       = 'running',
    $service_name         = 'opscenterd',
    $service_provider     = undef,
    $service_systemd      = false,
    $service_systemd_tmpl = 'opscenter/opscenterd.service.erb',
  ) inherits opscenter::params {
  if $service_provider != undef {
    System {
      provider => $service_provider,
    }
  }

  package { 'opscenter':
    ensure => $package_ensure,
    name   => $package_name,
    before => Service['opscenterd'],
  }

  if $service_systemd {
    $systemd_path = $::opscenter::params::systemd_path

    exec { 'opscenter_reload_systemctl':
      command     => "${::opscenter::params::systemctl} daemon-reload",
      refreshonly => true,
      notify      => Service['opscenterd'],
    }

    file { "${systemd_path}/${service_name}.service":
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      content => template($service_systemd_tmpl),
      mode    => '0644',
      before  => Package[$package_name],
      notify  => Exec['opscenter_reload_systemctl'],
    }
  }

  service { 'opscenterd':
    ensure => $service_ensure,
    name   => $service_name,
    enable => $service_enable,
  }
}
