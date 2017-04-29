class ucs::switch_config::enable_features{
   cisco_command_config{ "Enable_req_features_on__switch":
        command=> "feature udld
            feature lacp
            feature vpc
            feature interface-vlan",
    }
}

