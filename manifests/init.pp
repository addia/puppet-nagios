# == Class: nagios
# ===========================
#
#
# Description of the Class:
#
#   Install and configure a Nagios server for WebOps monitoring
#
#
# Document all Parameters:
#
#   Explanation of what this parameter affects and what it defaults to.
#     package_name                     = the package name
#     user                             = run as user
#     group                            = run as group
#     userid                           = default uid
#     grpuid                           = default gid
#     home_dir                         = nagios home directory
#     base_dir                         = nagios base config directory
#     private_dir                      = nagios privileges direcory
#     config_dir                       = nagios config config directory
#     commands_dir                     = the commands directory
#     servers_dir                      = the servers directory
#     services_dir                     = the services directory
#     nagios_server                    = the server url
#     nagios_server_ip                 = the server ip
#
# ===========================
#
#
# == Authors
# ----------
#
# Author: Addi <addi.abel@gmail.com>
#
#
# == Copyright
# ------------
#
# Copyright:  ©  2016  LR / Addi.
#
#
class nagios (
  $package_name                        = $nagios::params::package_name,
  $user                                = $nagios::params::user,
  $group                               = $nagios::params::group,
  $userid                              = $nagios::params::userid,
  $grpuid                              = $nagios::params::grpuid,
  $home_dir                            = $nagios::params::home_dir,
  $base_dir                            = $nagios::params::base_dir,
  $private_dir                         = $nagios::params::private_dir,
  $config_dir                          = $nagios::params::config_dir,
  $commands_dir                        = $nagios::params::commands_dir,
  $servers_dir                         = $nagios::params::servers_dir,
  $services_dir                        = $nagios::params::services_dir,
  $nagios_server                       = $nagios::params::nagios_server,
  $nagios_server_ip                    = $nagios::params::nagios_server_ip

  ) inherits nagios::params {

    notify { "## --->>> Install and configur ${package_name} server": }

    anchor { 'nagios::begin': } ->
    class { '::nagios::install': } ->
    class { '::nagios::config': } ->
    class { '::nagios::service': } ->
    anchor { 'nagios::end': }

  }


# vim: set ts=2 sw=2 et :
  
