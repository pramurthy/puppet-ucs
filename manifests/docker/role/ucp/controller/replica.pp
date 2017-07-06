class docker_ee_cvd::docker::role::ucp::controller::replica(
  $ucp_version         = $docker_ee_cvd::docker::params::version,
  $ucp_controller_node = undef,
  $ucp_controller_port = $docker_ee_cvd::docker::params::controller_port,
  $token               = $docker_ee_cvd::docker::params::token,
  $fingerprint         = $docker_ee_cvd::docker::params::fingerprint
) inherits docker_ee_cvd::docker::params {

 $replica_address = $facts['networking']['ip']

 class { 'docker_ddc::ucp':
   version           => $ucp_version,
   token             => $token,
   listen_address    => $replica_address,
   advertise_address => $replica_address,
   fingerprint       => $fingerprint,
   ucp_manager       => $ucp_controller_node,
   ucp_url           => "https://${$ucp_controller_node}:${ucp_controller_port}"
   }

}
