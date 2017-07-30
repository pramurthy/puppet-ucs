Facter.add('dtr_version') do
    setcode do
      Facter::Core::Execution.exec("docker image ls --format '{{.Tag}}' docker/dtr-registry  | head -n 1")
    end
end
