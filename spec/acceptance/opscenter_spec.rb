require 'spec_helper_acceptance'

describe 'opscenter class' do
  install_pp = <<-EOS
    if $::osfamily == 'RedHat' and $::operatingsystemmajrelease == 7 {
      $service_systemd = true
    } else {
      $service_systemd = false
    }

    class { 'opscenter::datastax_repo':
      before => Class['opscenter'],
    }

    class { 'opscenter::pycrypto':
      manage_epel => true,
    }

    class { 'opscenter':
      service_systemd => $service_systemd,
    }

    opscenter::cluster_name { 'Cluster1':
      cassandra_seed_hosts => 'localhost',
    }
  EOS

  describe 'Test installation.' do
    it 'Should run without error' do
      apply_manifest(install_pp,
                     catch_failures: true)
    end
  end
end
