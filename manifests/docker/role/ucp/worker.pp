class docker_ee_cvd::docker::role::ucp::worker(
  $ucp_controller_node     = undef,
) inherits docker_ee_cvd::docker::params {

  $worker_address = $facts['networking']['ip']

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

  $ucp_worker_token_query = "facts {
    name = \"ucp_worker_token\"  and certname = \"${ucp_controller_node}\" and certname in resources[certname] {
    }
  }"
  $ucp_worker_token = puppetdb_query($ucp_worker_token_query)[0]['value']

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
    token             => $ucp_worker_token,
    listen_address    => $worker_address,
    advertise_address => $worker_address,
    fingerprint       => $ucp_fingerprint,
    ucp_manager       => $ucp_ipaddress,
    ucp_url           => 'https://${$ucp_ipaddress}:$ucp_controller_port',
    require           => Class['docker'],
    }
}
