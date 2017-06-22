class docker_ee_cvd::docker::role::ucp::controller::master(
  $username           = $docker_ddc::params::ucp_username,
  $password           = $docker_ddc::params::ucp_password,
  $user_access_port   = $docker_ddc::params::controller_port,
  $version            = $docker_ddc::params::version,
  $docker_socket_path = $docker_ddc::params::docker_socket_path,
  $license_file       = $docker_ddc::params::license_file,
  $external_ca        = $docker_ddc::params::external_ca,
){

  $controller_ip = $facts['networking']['ip']

  class { 'docker_ddc::ucp':
    controller         => true,
    version            => $version,
    host_address       => $controller_ip,
    controller_port    => $user_access_port,
    docker_socket_path => $docker_socket_path,
    license_file       => $license_file,
    external_ca        => $external_ca,
    username           => $username,
    password           => $password,
    }   
}  
