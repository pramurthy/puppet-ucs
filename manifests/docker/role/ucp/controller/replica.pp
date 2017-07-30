class docker_ee_cvd::docker::role::ucp::controller::replica(
  $ucp_username            = $docker_ee_cvd::docker::params::ucp_username,
  $ucp_password            = $docker_ee_cvd::docker::params::ucp_password,
  $ucp_controller_node     = undef,
) inherits docker_ee_cvd::docker::params {

  $replica_address = $facts['networking']['ip']

  $ucp_ipaddress_query = "facts { 
    name = \"ipaddress\" and certname = \"${ucp_controller_node}\" and certname in resources[certname] {
    }
  }"
  $ucp_ipaddress = puppetdb_query($ucp_ipaddress_query)[0]['value']

  $ucp_fingerprint_query = "facts {
    name = \"ucp_fingerprint\" and certname = \"${ucp_controller_node}\" and certname in resources[certname] {
    }
  }"
  $ucp_fingerprint = puppetdb_query($ucp_fingerprint_query)[0]['value']

  $ucp_manager_token_query = "facts {
    name = \"ucp_manager_token\"  and certname = \"${ucp_controller_node}\" and certname in resources[certname] {
    }
  }"
  $ucp_manager_token = puppetdb_query($ucp_manager_token_query)[0]['value']

  $ucp_controller_port_query= "facts {
    name = \"ucp_controller_port\"  and certname = \"${ucp_controller_node}\" and certname in resources[certname] {
    }
  }"
  $ucp_controller_port = puppetdb_query($ucp_controller_port_query)[0]['value']

  $ucp_version_query= "facts {
    name = \"ucp_version\"  and certname = \"${ucp_controller_node}\" and certname in resources[certname] {
    }
  }"
  $ucp_version = puppetdb_query($ucp_version_query)[0]['value']

  Docker_ee_cvd::Docker::Engine <<| tag == "${ucp_controller_node}" |>>

  class { 'docker_ddc::ucp':
    version           => $ucp_version,
    token             => $ucp_manager_token,
    listen_address    => $replica_address,
    advertise_address => $replica_address,
    fingerprint       => $ucp_fingerprint,
    ucp_manager       => $ucp_ipaddress,
    ucp_url           => "https://${$ucp_ipaddress}:${ucp_controller_port}",
    username           => $ucp_username,
    password           => $ucp_password,
    require            => Class['docker'],
   }

}
