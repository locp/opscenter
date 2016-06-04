# opscenter::cluster_name
define opscenter::cluster_name(
  $config_path = '/etc/opscenter/clusters',
  $settings    = {},
  ) {
  include ::opscenter

  if ! defined( File[$config_path] ) {
    file { $config_path:
      ensure  => directory,
      purge   => $opscenter::config_purge,
      recurse => $opscenter::config_purge,
      require => Package['opscenter'],
    }
  }

  $cluster_file = "${config_path}/${title}.conf"

  file { "opscenter: ${title}":
    ensure  => present,
    path    => $cluster_file,
    mode    => '0644',
    require => Package['opscenter'],
  }

  $defaults = {
    ensure  => present,
    path    => $cluster_file,
    require => [
      File["opscenter: ${title}"],
      Package['opscenter']
    ],
    notify  => Service['opscenterd'],
  }

  create_ini_settings($settings, $defaults)
}
