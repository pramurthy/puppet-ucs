class docker_ee_cvd::docker::roles{

  $role=$facts['hostname']

  if $role =~ /^ucp-ctrl-(\d+)/ {
    include docker_ee_cvd::docker::engine
    include docker_ee_cvd::docker::role::ucp::controller::master
    contain docker_ee_cvd::docker::engine
    contain docker_ee_cvd::docker::role::ucp::controller::master
    Class['docker_ee_cvd::docker::engine']
    ->Class['docker_ee_cvd::docker::role::ucp::controller::master']
  }
  elsif $role =~ /^ucp-ctrl-replica-(\d+)/ {
    include docker_ee_cvd::docker::engine
    include docker_ee_cvd::docker::role::ucp::controller::replica
    contain docker_ee_cvd::docker::engine
    contain docker_ee_cvd::docker::role::ucp::controller::replica
    Class['docker_ee_cvd::docker::engine']
    ->Class['docker_ee_cvd::docker::role::ucp::controller::replica']
  }
  elsif $role =~ /^ucp-dtr-(\d+)/ {
    include docker_ee_cvd::docker::engine
    include docker_ee_cvd::docker::role::ucp::dtr::master
    contain docker_ee_cvd::docker::engine
    contain docker_ee_cvd::docker::role::ucp::dtr::master
    Class['docker_ee_cvd::docker::engine']
    ->Class['docker_ee_cvd::docker::role::ucp::dtr::master']
  }
  elsif $role =~ /^ucp-dtr-replica-(\d+)/ {
    include docker_ee_cvd::docker::engine
    include docker_ee_cvd::docker::role::ucp::dtr::replica
    contain docker_ee_cvd::docker::engine
    contain docker_ee_cvd::docker::role::ucp::dtr::replica
    Class['docker_ee_cvd::docker::engine']
    ->Class['docker_ee_cvd::docker::role::ucp::dtr::replica']
  }
  elsif $role =~ /^ucp-node-(\d+)/ {
    include docker_ee_cvd::docker::engine
    include docker_ee_cvd::docker::role::ucp::worker
    contain docker_ee_cvd::docker::engine
    contain docker_ee_cvd::docker::role::ucp::worker
    Class['docker_ee_cvd::docker::engine']
    ->Class['docker_ee_cvd::docker::role::ucp::worker']
  }
  else {
    notice("Role does not match")
  }
}

