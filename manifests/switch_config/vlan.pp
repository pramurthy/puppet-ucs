class ucs::switch_config::vlan(
  $vlan_list=undef,
){

    #create vlans
    if ( $vlan_list != undef ){
        $vlan_list.each |String $vlan|{
            $vlan_name="vlan${vlan}"
            cisco_vlan { $vlan:
                        ensure         => present,
                        vlan_name      => $vlan_name,
                        shutdown       => false,
                        state          => 'active',
            }
        }
    }
}
