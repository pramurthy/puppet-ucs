class ucs::docker::install_docker_engine{
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
       command     => 'rpm --import "https://sks-keyservers.net/pks/lookup?op=get&search=0xee6d536cf7dc86e2d7d56f59a178ac6c6238f52e"',
       path        => ['/usr/bin', '/usr/sbin']
    }

    yumrepo { "dockerrepo":
        baseurl => "https://packages.docker.com/1.13/yum/repo/main/centos/7",
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
