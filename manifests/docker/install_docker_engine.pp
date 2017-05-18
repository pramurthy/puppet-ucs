class ucs::docker::install_docker_engine(
    $version=1.12,
    $docker_public_key="https://sks-keyservers.net/pks/lookup?op=get&search=0xee6d536cf7dc86e2d7d56f59a178ac6c6238f52e"
    ){

    $os_version=$facts['os']['release']['major']

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

    service {'firewalld':
        ensure => 'running',
        enable => 'true',
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
