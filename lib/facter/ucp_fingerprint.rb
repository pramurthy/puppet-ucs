Facter.add('ucp_fingerprint') do
    setcode do
      Facter::Core::Execution.exec("docker run --rm -i --name ucp   -v /var/run/docker.sock:/var/run/docker.sock   docker/ucp fingerprint | sed 's/.*=//'")
    end
end
