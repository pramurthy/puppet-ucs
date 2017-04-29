class ucs::switch_config::host_interface(
  $interface_list=undef,
){
    if ( $interface_list != undef){
        #require port-channels to be created - if the interface is part of any port-channel

        $interface_list.each |$interface|{
            cisco_interface{"${interface['name']}":
                ensure       => present,
                *            => $interface,
                shutdown     => false,
            }
#            cisco_command_config{ "Enable_udld_on_${interface['name']}":
#                command=> "interface ${interface['name']}
#                            udld enable",
#            }
        }
    }
}

