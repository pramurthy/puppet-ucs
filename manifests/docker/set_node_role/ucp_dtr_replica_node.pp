class ucs::docker::set_node_role::ucp_dtr_replica_node(
    $ucp_controller_node_ip='10.11.0.69',
    $ucp_controller_node_user='admin',
    $ucp_controller_node_pass='maplelabs',
    $ucp_controller_node_port='19002',
    $existing_replica_id='c96ccdbd5220',
){

    $dtr_node_hostname=$facts['networking']['hostname']

    docker_ddc::dtr {'Dtr install':
    join => true,
    dtr_version => 'latest',
    ucp_node => $dtr_node_hostname,
    ucp_username => $ucp_controller_node_user,
    ucp_password => $ucp_controller_node_pass,
    ucp_insecure_tls => true,
    dtr_ucp_url => "https://${$ucp_controller_node_ip}:${ucp_controller_node_port}",
    dtr_existing_replica_id => $existing_replica_id
    }

}
