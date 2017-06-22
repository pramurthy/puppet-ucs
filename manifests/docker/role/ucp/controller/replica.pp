class docker_ee_cvd::docker::role::ucp::controller::replica(
  $ucp_version         = $docker_ddc::params::version,
  $ucp_controller_node = undef,
  $ucp_controller_port = $docker_ddc::params::controller_port,
  $token               = $docker_ddc::params::token,

){

 $replica_address = $facts['networking']['ip']
 $fingerprint     = "echo -n | openssl s_client -connect ${$ucp_controller_node}:${ucp_controller_port} 2> /dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' | openssl x509 -noout     -fingerprint -sha256"

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
