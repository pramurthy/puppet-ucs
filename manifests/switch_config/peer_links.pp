class ucs::switch_config::peer_links(
  $interface_list
){

    #configuring peerkeepalive interfaces
    $interface_list.each |$interface_data|{
        cisco_interface{ "${interface_data['interface_name']}":
            ensure       => present,
            interface    => $interface_data['interface_name'],
            shutdown     => false,
            description  => $interface_data['description'],
        }
#       cisco_command_config{ "Enable_udld_on_${interface['name']}":
#           command=> "interface ${interface['name']}
#                       udld enable",
#       }
    }
}
