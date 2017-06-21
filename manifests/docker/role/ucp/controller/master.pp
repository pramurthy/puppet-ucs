class docker_ee_cvd::docker::role::ucp::controller::master(
  $username         = 'admin',
  $password         = 'maplelabs',
  $user_access_port = '19002',
  $version          = '2.1.4'
){

  $controller_ip = $facts['networking']['ip']

  class { 'docker_ddc::ucp':
    controller         => true,
    version            => $version,
    host_address       => $controller_ip,
    controller_port    => $user_access_port,
    docker_socket_path => '/var/run/docker.sock',
    license_file       => '/etc/docker/subscription.lic',
    external_ca        => false,
    username           => $username,
    password           => $password,
    }   
}  
