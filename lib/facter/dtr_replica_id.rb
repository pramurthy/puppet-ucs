Facter.add('dtr_replica_id') do
    setcode do
      Facter::Core::Execution.exec("docker ps | grep dtr-registry | sed 's/.*y-//'")
    end
end

