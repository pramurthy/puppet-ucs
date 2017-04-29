# ucs

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with ucs](#setup)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)

## Description

Puppet-UCS module is used to configure the Cisco UCS Infrastructure with Docker Datacenter for Container Management.

This module configures the leaf switches(N9K)  used in Cisco UCS Infrastructure and configures the UCS Manager.

## Setup

The setup employs puppet master/agent architecture.

### Setting environment for  Cisco N9K swithes
Please refer https://github.com/puppetlabs/bdcisco-module-evpn_vxlan for setting Puppet environment on Cisco N9K switches and Pupet-Enterprise Server.

### Modules required on Puppet-Enterprise Server
This module requires "puppetlabs-ciscopuppet" puppet module to be installed on the Puppet-Enterprise Server.

 ```
 puppet module instal puppetlabs-ciscopuppet --version 1.6.0
 ```

## Reference
Below is the list of classes in this module used to configure Cisco N9K switches.
![alt tag](https://github.com/pramurthy/puppet-ucs/blob/master/images/Resources_exposed.png)

Topology used for Cisco N9K switches
![alt tag](https://github.com/pramurthy/puppet-ucs/blob/master/images/Topology.png)
