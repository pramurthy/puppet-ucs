class docker_ee_cvd::docker::role::ucp::controller::replica(
  $ucp_username            = $docker_ee_cvd::docker::params::ucp_username,
  $ucp_password            = $docker_ee_cvd::docker::params::ucp_password,
) inherits docker_ee_cvd::docker::params {

  $replica_address = $facts['networking']['ip']

  $ucp_hostname_query= 'facts {
    name = "hostname" and certname in resources[certname] {
     type = "Class" and title = "Docker_ee_cvd::Docker::Role::Ucp::Controller::Master"
    }
  }'

  $ucp_ipaddress_query= 'facts {
    name = "ipaddress" and certname in resources[certname] {
     type = "Class" and title = "Docker_ee_cvd::Docker::Role::Ucp::Controller::Master" 
    }
  }'

  $ucp_fingerprint_query = 'facts {
    name = "ucp_fingerprint" and certname in resources[certname] {
     type = "Class" and title = "Docker_ee_cvd::Docker::Role::Ucp::Controller::Master" 
    }
  }'

  $ucp_manager_token_query = 'facts {
    name = "ucp_manager_token" and certname in resources[certname] {
     type = "Class" and title = "Docker_ee_cvd::Docker::Role::Ucp::Controller::Master" 
    }
  }'

  $ucp_controller_port_query = 'facts {
    name = "ucp_controller_port" and certname in resources[certname] {
     type = "Class" and title = "Docker_ee_cvd::Docker::Role::Ucp::Controller::Master" 
    }
  }'

  $ucp_version_query = 'facts {
    name = "ucp_version" and certname in resources[certname] {
     type = "Class" and title = "Docker_ee_cvd::Docker::Role::Ucp::Controller::Master" 
    }
  }'

  $ucp_controller_node = puppetdb_query($ucp_hostname_query)[0]['value']
  $ucp_version         = puppetdb_query($ucp_version_query)[0]['value']
  $ucp_ipaddress       = puppetdb_query($ucp_ipaddress_query)[0]['value']
  $ucp_controller_port = puppetdb_query($ucp_controller_port_query)[0]['value']
  $ucp_manager_token   = puppetdb_query($ucp_manager_token_query)[0]['value']
  $ucp_fingerprint     = puppetdb_query($ucp_fingerprint_query)[0]['value']

  Docker_ee_cvd::Docker::Engine <<| tag == "${ucp_controller_node}" |>>

  class { 'docker_ddc::ucp':
    version           => $ucp_version,
    token             => $ucp_manager_token,
    listen_address    => $replica_address,
    advertise_address => $replica_address,
    fingerprint       => $ucp_fingerprint,
    ucp_manager       => $ucp_ipaddress,
    ucp_url           => "https://${$ucp_ipaddress}:${ucp_controller_port}",
    username          => $ucp_username,
    password          => $ucp_password,
    require           => Class['docker'],
    local_client      => $docker_ee_cvd::docker::params::local_client,
   }
}
