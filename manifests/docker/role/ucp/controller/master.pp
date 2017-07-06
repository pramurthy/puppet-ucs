class docker_ee_cvd::docker::role::ucp::controller::master(
  $username           = $docker_ee_cvd::docker::params::ucp_username,
  $password           = $docker_ee_cvd::docker::params::ucp_password,
  $user_access_port   = $docker_ee_cvd::docker::params::controller_port,
  $version            = $docker_ee_cvd::docker::params::version,
  $docker_socket_path = $docker_ee_cvd::docker::params::docker_socket_path,
  $license_file       = $docker_ee_cvd::docker::params::license_file,
  $external_ca        = $docker_ee_cvd::docker::params::external_ca,
) inherits docker_ee_cvd::docker::params {

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
