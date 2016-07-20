require 'spec_helper_acceptance'

describe 'opscenter class' do
  install_cassandra_pp = <<-EOS
    if $::osfamily == 'RedHat' and $::operatingsystemmajrelease == 7 {
      $service_systemd = true
    } else {
      $service_systemd = false
    }

    if $::osfamily == 'RedHat' {
      $cassandra_package = 'cassandra20'
      $version = '3.0.8-1'

      class { 'cassandra::java':
        before => Class['cassandra']
      }
    } else {
      if $::lsbdistid == 'Ubuntu' {
        class { 'cassandra::java':
          aptkey       => {
            'openjdk-r' => {
              id     => 'DA1A4A13543B466853BAF164EB9B1D8886F44E2A',
              server => 'keyserver.ubuntu.com',
            },
          },
          aptsource    => {
            'openjdk-r' => {
              location => 'http://ppa.launchpad.net/openjdk-r/ppa/ubuntu',
              comment  => 'OpenJDK builds (all archs)',
              release  => $::lsbdistcodename,
              repos    => 'main',
            },
          },
          package_name => 'openjdk-8-jdk',
        }
      } else {
        class { 'cassandra::java':
          aptkey       => {
            'ZuluJDK' => {
              id     => '27BC0C8CB3D81623F59BDADCB1998361219BD9C9',
              server => 'keyserver.ubuntu.com',
            },
          },
          aptsource    => {
            'ZuluJDK' => {
              location => 'http://repos.azulsystems.com/debian',
              comment  => 'Zulu OpenJDK 8 for Debian',
              release  => 'stable',
              repos    => 'main',
            },
          },
          package_name => 'zulu-8',
        }
      }

      $cassandra_package = 'cassandra'
      $version = '3.0.8'

      exec { '/bin/chown root:root /etc/apt/sources.list.d/datastax.list':
        unless  => '/usr/bin/test -O /etc/apt/sources.list.d/datastax.list',
        require => Class['cassandra::datastax_agent', 'opscenter', 'opscenter::datastax_repo']
      }
    }

    class { 'opscenter::datastax_repo':
      before => Class['cassandra', 'opscenter'],
    }

    class { 'cassandra':
      authenticator               => 'PasswordAuthenticator',
      cassandra_9822              => true,
      cassandra_yaml_tmpl         => 'cassandra/cassandra20.yaml.erb',
      commitlog_directory_mode    => '0770',
      data_file_directories_mode  => '0770',
      dc                          => 'LON',
      rack                        => 'R101',
      package_ensure              => $version,
      package_name                => $cassandra_package,
      saved_caches_directory_mode => '0770',
      service_systemd             => $service_systemd
    }

    class { 'cassandra::datastax_agent':
      service_systemd => $service_systemd,
      require         => Class['cassandra']
    }
  EOS

  install_opscenter_pp = <<-EOS
    class { 'opscenter::pycrypto':
      manage_epel => true,
    }

    class { 'opscenter':
      settings => {
        'authentication' => {
          'enabled' => 'True',
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
  EOS

  describe 'Cassandra installation.' do
    it 'Should run without error.' do
      apply_manifest(install_cassandra_pp, catch_failures: true)
    end

    it 'Check code is idempotent.' do
      expect(apply_manifest(install_cassandra_pp, catch_failures: true).exit_code).to be_zero
    end
  end

  describe 'OpsCenter installation.' do
    it 'Should run without error.' do
      apply_manifest(install_opscenter_pp, catch_failures: true)
    end

    it 'Check code is idempotent.' do
      expect(apply_manifest(install_opscenter_pp, catch_failures: true).exit_code).to be_zero
    end
  end

  legacy_check_pp = <<-EOS
    if $::osfamily == 'RedHat' and $::operatingsystemmajrelease == 7 {
      $service_systemd = true
    } else {
      $service_systemd = false
    }

    class { 'cassandra::opscenter::pycrypto':
      manage_epel => true,
    }

    class { 'cassandra::opscenter':
      authentication_enabled => 'True',
      service_systemd        => $service_systemd,
    }

    cassandra::opscenter::cluster_name { 'Cluster1':
      cassandra_seed_hosts => 'localhost',
    }
  EOS

  describe 'Check compatibility with locp-cassandra.' do
    it 'Check code is idempotent.' do
      expect(apply_manifest(legacy_check_pp, catch_failures: true).exit_code).to be_zero
    end
  end
end
