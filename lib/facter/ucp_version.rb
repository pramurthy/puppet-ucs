Facter.add('ucp_version') do
    setcode do
      Facter::Core::Execution.exec("docker image ls --format '{{.Tag}}' docker/ucp-auth | head -n 1")
    end
end
