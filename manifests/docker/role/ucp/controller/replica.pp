class docker_ee_cvd::docker::role::ucp::controller::replica(
  $ucp_version         = '2.1.4',
  $ucp_controller_node = '10.11.0.69',
  $ucp_controller_port = '19002',
  $token               = 'SWMTKN-1-0c3txh59nhpbe611o036xia2jfldsz6bib7ef1thfi9a97rshf-0eydm5vfxevjo256evunmzlo3',

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
