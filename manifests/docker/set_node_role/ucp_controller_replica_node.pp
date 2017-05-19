class ucs::docker::set_node_role::ucp_controller_replica_node(
    $ucp_version='2.1.4',
    $ucp_controller_node='10.11.0.39',
    $ucp_controller_port='19002',
    $token='SWMTKN-1-21ilhmmhkgb2v1qscwxn3uuewz1kwmcsadlyerpem6jum6a9vm-am7c0gw0rs1i1lbzol1724l64',
    $fingerprint='9F:A3:40:14:25:19:6C:10:C2:A6:70:AE:B8:BA:BF:50:1E:90:DB:CF:13:5C:32:35:51:0E:01:46:7E:DB:9E:D5',

){

    $replica_address=$facts['networking']['ip']
    class { 'docker_ucp':
        version => $ucp_version,
        token => $token,
        listen_address => $replica_address,
        advertise_address => $replica_address,
        fingerprint => $fingerprint,
        ucp_manager => $ucp_controller_node,
        ucp_url => "https://${$ucp_controller_node}:${ucp_controller_port}"
    }

}
