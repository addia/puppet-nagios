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
#     uid                              = default uid/gid
#     home_dir                         = nagios home directory
#     base_dir                         = nagios base config directory
#     config_dir                       = nagios config config directory
#     commands_dir                     = the commands directory
#     servers_dir                      = the servers directory
#     services_dir                     = the services directory
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
  $uid                                 = $nagios::params::uid,
  $home_dir                            = $nagios::params::home_dir,
  $base_dir                            = $nagios::params::base_dir,
  $config_dir                          = $nagios::params::config_dir,
  $commands_dir                        = $nagios::params::commands_dir,
  $servers_dir                         = $nagios::params::servers_dir,
  $services_dir                        = $nagios::params::services_dir

  ) inherits nagios::params {

    notify { "## --->>> Installing and configuring ${package_name}": }

    anchor { 'nagios::begin': } ->
    #class { '::nagios::account': } ->
    class { '::nagios::install': } ->
    class { '::nagios::config': } ->
    class { '::nagios::service': } ->
    anchor { 'nagios::end': }

  }


# vim: set ts=2 sw=2 et :
  
