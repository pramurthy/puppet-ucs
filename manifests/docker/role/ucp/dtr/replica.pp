class docker_ee_cvd::docker::role::ucp::dtr::replica(
  $ucp_dtr_node        = undef,
  $ucp_controller_node = undef,
  $ucp_username        = $docker_ee_cvd::docker::params::ucp_username,
  $ucp_password        = $docker_ee_cvd::docker::params::ucp_password,
) inherits docker_ee_cvd::docker::params {

  $ucp_ipaddress_query = "facts {
    name = \"ipaddress\" and certname = \"${ucp_controller_node}\" and certname in resources[certname] {
    }
  }"

  $ucp_controller_port_query= "facts {
    name = \"ucp_controller_port\"  and certname = \"${ucp_controller_node}\" and certname in resources[certname] {
    }
  }"

  $dtr_replica_id_query = "facts {
    name = \"dtr_replica_id\" and certname = \"${ucp_dtr_node}\" and certname in resources[certname] {
    }
  }"

  $dtr_version_query= "facts {
    name = \"dtr_version\"  and certname = \"${ucp_dtr_node}\" and certname in resources[certname] {
    }
  }"

  $dtr_node_ip         = $facts['networking']['ip']
  $dtr_node_hostname   = $facts['networking']['fqdn']
  $ucp_ipaddress       = puppetdb_query($ucp_ipaddress_query)[0]['value']
  $ucp_controller_port = puppetdb_query($ucp_controller_port_query)[0]['value']
  $dtr_replica_id      = puppetdb_query($dtr_replica_id_query)[0]['value']
  $dtr_version         = puppetdb_query($dtr_version_query)[0]['value']


  class { 'docker_ee_cvd::docker::role::ucp::worker':
    ucp_controller_node => $ucp_controller_node,
    require             => Class['docker'],
  }

  exec { 'DTR sleep time':
    command => 'sleep 90',
    path    => ['/usr/bin', '/usr/sbin',],
    require => Class['docker_ee_cvd::docker::role::ucp::worker'],
  } 

  docker_ddc::dtr { 'Dtr install':
    join                    => true,
    dtr_version             => $dtr_version,
    ucp_node                => $dtr_node_hostname,
    ucp_username            => $ucp_username,
    ucp_password            => $ucp_password,
    ucp_insecure_tls        => true,
    dtr_existing_replica_id => $dtr_replica_id,
    dtr_ucp_url             => "https://${ucp_ipaddress}:${ucp_controller_port}",
    require                 => Exec['DTR sleep time'],
  }

}
