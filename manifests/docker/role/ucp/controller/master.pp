class docker_ee_cvd::docker::role::ucp::controller::master(
  $ucp_username            = $docker_ee_cvd::docker::params::ucp_username,
  $ucp_password            = $docker_ee_cvd::docker::params::ucp_password,
  $ucp_controller_port     = $docker_ee_cvd::docker::params::ucp_controller_port,
  $ucp_version             = $docker_ee_cvd::docker::params::ucp_version,
  $docker_socket_path      = $docker_ee_cvd::docker::params::docker_socket_path,
  $license_file            = $docker_ee_cvd::docker::params::license_file,
  $external_ca             = $docker_ee_cvd::docker::params::external_ca,
  $package_source_location = $docker_ee_cvd::docker::params::package_source_location,
  $package_key_source      = $docker_ee_cvd::docker::params::package_key_source,
  $package_repos           = $docker_ee_cvd::docker::params::package_repos,
) inherits docker_ee_cvd::docker::params {

  $controller_ip       = $facts['networking']['ip']
  $ucp_controller_node = $facts['networking']['fqdn']

  @@docker_ee_cvd::docker::engine { "${package_repos}" :
     package_source_location  => $package_source_location,
     package_key_source       => $package_key_source,
     tag                      => "${ucp_controller_node}",
  }
  
  Docker_ee_cvd::Docker::Engine <<| tag == "${ucp_controller_node}" |>>

  class { 'docker_ddc::ucp':
    controller         => true,
    version            => $ucp_version,
    host_address       => $controller_ip,
    controller_port    => $ucp_controller_port,
    docker_socket_path => $docker_socket_path,
    license_file       => $license_file,
    external_ca        => $external_ca,
    username           => $ucp_username,
    password           => $ucp_password,
    require            => Class['docker'],
    local_client       => $docker_ee_cvd::docker::params::local_client,
  }
}
