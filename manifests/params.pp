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
  $uid                                 = '240'
  $guid                                = '240'
  $home_dir                            = '/var/spool/nagios'
  $base_dir                            = '/etc/nagios/objects'
  $commands_dir                        = '/etc/nagios/objects/commands'
  $servers_dir                         = '/etc/nagios/objects/servers'
  $services_dir                        = '/etc/nagios/objects/services'

  }


# vim: set ts=2 sw=2 et :
