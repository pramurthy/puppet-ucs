class ucs::switch_config::vpc_domain(
  $vpc_domain_id,
  $peer_gateway=false,
  $peer_keepalive_dest,
  $peer_keepalive_src,
  $peer_keepalive_vrf=undef,
  $role_priority=32667,
  $delay_restore=240,
){

    if ($peer_keepalive_vrf!=undef){
        cisco_vrf{"${peer_keepalive_vrf}":
            ensure      => present,
            shutdown    => false,
        }
    }
    cisco_vpc_domain{ "${vpc_domain_id}":
        ensure              => present,
        domain              => $vpc_domain_id,
        peer_gateway        => $peer_gateway,
        peer_keepalive_dest => $peer_keepalive_dest,
        peer_keepalive_src  => $peer_keepalive_src,
        peer_keepalive_vrf  => $peer_keepalive_vrf,
        role_priority       => $role_priority,
        auto_recovery       => true,
        delay_restore       => $delay_restore,
    }
    cisco_command_config{"${vpc_domain_id}":
        command  => "vpc domain ${vpc_domain_id} \n ip arp synchronize \n peer-switch"
    }
}
