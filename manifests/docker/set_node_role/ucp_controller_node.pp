class ucs::docker::set_node_role::ucp_controller_node(
    $username='admin',
    $password='maplelabs',
    $user_access_port='19002'
){

    $controller_ip=$facts['networking']['ip']
    class { 'docker_ucp':
        controller                => true,
        host_address              => $controller_ip,
        controller_port           => $user_access_port,
        docker_socket_path        => '/var/run/docker.sock',
        license_file              => '/etc/docker/subscription.lic',
        username                  => $username,
        password                  => $password,
    }

}
    
