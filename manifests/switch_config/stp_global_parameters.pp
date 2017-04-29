class ucs::switch_config::stp_global_parameters{
   cisco_stp_global{'default':
      bpdufilter               => true,
      bpduguard                => true,
   }
   
   cisco_command_config{ "Enable_port_type_network_default":
        command=> "spanning-tree port type network default",
    }
}

