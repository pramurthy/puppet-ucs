class docker_ee_cvd::docker::role::ucp::dtr::replica(
  $ucp_controller_node_ip   = undef,
  $ucp_controller_node_user = $docker_ee_cvd::docker::params::version,
  $ucp_controller_node_pass = $docker_ee_cvd::docker::params::ucp_password,
  $ucp_controller_node_port = $docker_ee_cvd::docker::params::controller_port,
  $existing_replica_id      = undef,
) inherits docker_ee_cvd::docker::params {

  $dtr_node_hostname = $facts['networking']['fqdn']

  docker_ddc::dtr { 'Dtr install':
    join                    => true,
    dtr_version             => 'latest',
    ucp_node                => $dtr_node_hostname,
    ucp_username            => $ucp_controller_node_user,
    ucp_password            => $ucp_controller_node_pass,
    ucp_insecure_tls        => true,
    dtr_ucp_url             => "https://${$ucp_controller_node_ip}:${ucp_controller_node_port}",
    dtr_existing_replica_id => $existing_replica_id
    }
}
