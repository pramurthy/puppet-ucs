Facter.add('ucp_worker_token') do
    setcode do
      Facter::Core::Execution.exec("docker swarm join-token --quiet worker")
    end
end
