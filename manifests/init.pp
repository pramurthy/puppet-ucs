# Class: ucs
# ===========================
#
# Full description of class ucs here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'ucs':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class ucs {

   include docker_ee_cvd::docker::engine
   include docker_ee_cvd::docker::role::ucp::controller::master
   include docker_ee_cvd::docker::role::ucp::controller::replica
   include docker_ee_cvd::docker::role::ucp::dtr::master
   include docker_ee_cvd::docker::role::ucp::dtr::replica
   include docker_ee_cvd::docker::role::ucp::worker

   include ucs::switch_config::install_prerequisite_puppet_modules
   include ucs::switch_config::enable_features
   include ucs::switch_config::stp_global_parameters
   include ucs::switch_config::vlan
   include ucs::switch_config::peer_links
   include ucs::switch_config::vpc_domain
   include ucs::switch_config::host_interface
   include ucs::switch_config::portchannel

   Class['ucs::switch_config::peer_links'] ->
   Class['ucs::switch_config::host_interface'] ->
   Class['ucs::switch_config::portchannel']

}
