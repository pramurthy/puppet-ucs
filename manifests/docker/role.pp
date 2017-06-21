class docker_ee_cvd::docker::roles{

  $role=$facts['hostname']

  if $role =~ /^ucp-ctrl-(\d+)/ {
    include docker_ee_cvd::docker::role::ucp::controller
  }
  elsif $role =~ /^ucp-ctrl-replica-(\d+)/ {
    include docker_ee_cvd::docker::role::ucp::controller::replica
  }
  elsif $role =~ /^ucp-dtr-(\d+)/ {
    include docker_ee_cvd::docker::role::ucp::dtr
  }
  elsif $role =~ /^ucp-dtr-replica-(\d+)/ {
    include docker_ee_cvd::docker::role::ucp::dtr::replica
  }
  elsif $role =~ /^ucp-node-(\d+)/ {
    include docker_ee_cvd::docker::role::ucp::worker
  }
  else {
    notice("Role does not match")
  }
}

