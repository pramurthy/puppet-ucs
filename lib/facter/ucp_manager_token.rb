Facter.add('ucp_manager_token') do
    setcode do
      Facter::Core::Execution.exec("docker swarm join-token --quiet manager")
    end
end
