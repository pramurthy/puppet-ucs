class ucs::switch_config::install_prerequisite_puppet_modules(
  String $repo = 'https://rubygems.org',
  String $proxy = '',
){

  # Process proxy settings 
  if $proxy == '' {
    $opts = {}
  }
  else {
    $opts = { '--http-proxy' => $proxy }
  }

  package { 'cisco_node_utils' :
    ensure          => present,
    provider        => 'gem',
    source          => $repo,
    install_options => $opts,
  }
}
