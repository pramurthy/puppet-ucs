class ucs::docker::set_node_role::ucp_worker_node(
    $ucp_version='2.1.4',
    $ucp_controller_node='10.11.0.69',
    $ucp_controller_port='19002',
    $token='SWMTKN-1-0c3txh59nhpbe611o036xia2jfldsz6bib7ef1thfi9a97rshf-3uekr3vn2vid9q954xmd0pg84',
    $fingerprint='3D:D3:38:FD:E7:3A:E4:F2:1A:9C:48:86:2F:D0:89:8F:55:77:38:1F:9D:7D:78:8F:3D:26:60:0D:89:7A:03:C7',
){

    $worker_address=$facts['networking']['ip']
    class { 'docker_ucp':
         version => $ucp_version,
         token => $token,
         listen_address => $worker_address,
         advertise_address => $worker_address,
         fingerprint => $fingerprint,
         ucp_manager => $ucp_controller_node,
         ucp_url => 'https://${$ucp_controller_node}:$ucp_controller_port',
    }

}
