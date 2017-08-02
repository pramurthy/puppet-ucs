class docker_ee_cvd::docker::params inherits docker_ddc::params {
    $ucp_username            = 'admin'
    $ucp_password            = 'puppetlabs'
    $ucp_controller_port     = '19002'
    $ucp_version             = '2.1.4'
    $dtr_version             = 'latest'
    $docker_socket_path      = '/var/run/docker.sock'
    $license_file            = '/etc/docker/subscription.lic'
    $external_ca             = false
    $package_source_location = 'https://storebits.docker.com/ee/centos/sub-4ad5c2c8-5962-49d2-bb65-93aa9249c3d8/7/x86_64/stable-17.03/'
    $package_key_source      = 'https://storebits.docker.com/ee/centos/sub-4ad5c2c8-5962-49d2-bb65-93aa9249c3d8/gpg'
    $package_repos           = 'stable-17.03'
    #it's a temporary fix
    $local_client            = true
}
