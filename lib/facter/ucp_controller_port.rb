Facter.add('ucp_controller_port') do
    setcode do
      Facter::Core::Execution.exec("docker ps --filter 'name=ucp-controller'  --format '{{.Ports}}' | head -n 1 | cut -d ':' -f2| cut -d '-' -f1")
    end
end

