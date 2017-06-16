class ucs::docker::ucsddc{

    $role=$facts['hostname']

    include ucs::docker::install_docker_engine

    if $role =~ /^ucp-ctrl-(\d+)/ {
        include ucs::docker::set_node_role::ucp_controller_node
    }

    elsif $role =~ /^ucp-ctrl-replica-(\d+)/ {
        include ucs::docker::set_node_role::ucp_controller_replica_node
    }

    elsif $role =~ /^ucp-dtr-(\d+)/ {
        include ucs::docker::set_node_role::ucp_dtr_node
    }

    elsif $role =~ /^ucp-dtr-replica-(\d+)/ {
        include ucs::docker::set_node_role::ucp_dtr_replica_node
    }

    elsif $role =~ /^ucp-node-(\d+)/ {
        include ucs::docker::set_node_role::ucp_worker_node
    }

    else {
        notice("Role does not match")
    }

}

