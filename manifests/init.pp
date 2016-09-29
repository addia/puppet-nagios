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
  $home_dir                            = $nagios::params::home_dir

  ) inherits nagios::params {

    notify { "## --->>> Installing and configuring ${package_name}": }

    anchor { 'nagios::begin': } ->
    class { '::nagios::account': } ->
    class { '::nagios::install': } ->
    class { '::nagios::config': } ->
    class { '::nagios::service': } ->
    anchor { 'nagios::end': }

}


# vim: set ts=2 sw=2 et :
  
