class ucs::docker::install_docker_engine(
 $version=1.12,
 $docker_public_key="https://sks-keyservers.net/pks/lookup?op=get&search=0xee6d536cf7dc86e2d7d56f59a178ac6c6238f52e"
 ){

    $os_version=$facts['os']['release']['major']
    $tcp_fw_ports=[80,443,2375,2376,2377,4789,7946,12376,12379,12380,12381,12382,12383,12384,12385,12386,12387,19002,8443]
    $udp_fw_ports=[4789,7946]

    package { 'ntp':
        ensure          => installed,
    }

    service { "apache2":
        ensure  => running,
        enable => true,
        start   => "systemctl start ntpd.service",
    }

    $tcp_fw_ports.each |Integer $tport| {
      firewalld_port {"Open tport ${tport} in the public Zone":
          ensure => 'present',
          zone => 'public',
          port => "${tport}",
          protocol => 'tcp',
          }
    } 

    $udp_fw_ports.each |Integer $uport| {
      firewalld_port {"Open uport ${uport} in the public Zone":
          ensure => 'present',
          zone => 'public',
          port => "${uport}",
          protocol => 'udp',
          }
    }

    exec { 'firewalld-restart':
       command     => 'service firewalld restart',
       path        => ['/usr/bin', '/usr/sbin']
    }

    package { "epel-release":
        ensure   => absent,
    }

    exec { 'database-cleanup':
       command     => 'yum clean all',
       path        => ['/usr/bin', '/usr/sbin']
    }

    package {'yum-utils':
        ensure => present
    }


    exec { 'Docker-public-key':
       command     => "rpm --import ${docker_public_key}",
       path        => ['/usr/bin', '/usr/sbin']
    }

    yumrepo { "dockerrepo":
        baseurl => "https://packages.docker.com/${version}/yum/repo/main/centos/${os_version}",
        descr => "Docker Repo",
        enabled => 1,
        gpgcheck => 0,
    }

    exec { 'yum-repolist':
       command     => 'yum repolist',
       path        => ['/usr/bin', '/usr/sbin']
    }

    class { 'docker':
        docker_cs => true,
    }
}
