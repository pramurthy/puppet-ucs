class docker_ee_cvd::docker::role::ucp::dtr::master(
  $ucp_controller_node_ip   = undef,
  $ucp_controller_node_user = $docker_ee_cvd::docker::params::ucp_username,
  $ucp_controller_node_pass = $docker_ee_cvd::docker::params::ucp_password,
  $ucp_controller_node_port = $docker_ee_cvd::docker::params::controller_port,
) inherits docker_ee_cvd::docker::params {

  $dtr_node_ip       = $facts['networking']['ip']
  $dtr_node_hostname = $facts['networking']['fqdn']

  docker_ddc::dtr { 'Dtr install':
    install          => true,
    dtr_version      => 'latest',
    dtr_external_url => "https://${dtr_node_ip}",
    ucp_node         => $dtr_node_hostname,
    ucp_username     => $ucp_controller_node_user,
    ucp_password     => $ucp_controller_node_pass,
    ucp_insecure_tls => true,
    dtr_ucp_url      => "https://${ucp_controller_node_ip}:${ucp_controller_node_port}",
    }
}

