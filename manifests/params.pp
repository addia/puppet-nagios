# == Class nagios::params
# ===========================
#
#
# Description of the Class:
#
#   This class is meant to be called from init.pp only.
#
#
# ===========================
#
class nagios::params {

  $package_name                        = 'nagios'
  $user                                = 'nagios'
  $group                               = 'nagios'
  $userid                              = '240'
  $grpuid                              = '240'
  $home_dir                            = '/var/spool/nagios'
  $base_dir                            = '/etc/nagios/objects'
  $private_dir                         = '/etc/nagios'
  $config_dir                          = '/etc/nagios'
  $commands_dir                        = '/etc/nagios/objects/commands'
  $servers_dir                         = '/etc/nagios/objects/servers'
  $services_dir                        = '/etc/nagios/objects/services'
  $nagios_server                       = hiera('nagios_server_name')
  $nagios_server_ip                    = hiera('nagios_server_ip')
  }


# vim: set ts=2 sw=2 et :
