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
  $objects_dir                         = '/etc/nagios/objects'
  $private_dir                         = '/etc/nagios/private'
  $config_dir                          = '/etc/nagios'
  $commands_dir                        = '/etc/nagios/objects/commands'
  $servers_dir                         = '/etc/nagios/objects/servers'
  $services_dir                        = '/etc/nagios/objects/services'
  $home_dir                            = hiera('nagios_home_dir')
  $plugin_dir                          = hiera('nagios_plugin_dir')
  $admin_passwd                        = hiera('nagios_admin_passwd')
  $readonly_passwd                     = hiera('nagios_readonly_passwd')
  $notification_email                  = hiera('nagios_notification_email')
  $perfdata_perl                       = hiera('nagios_perfdata_perl')
  $perfdata_spool                      = hiera('nagios_perfdata_spool')
  $nagios_server                       = hiera('nagios_server_name')
  $nagios_server_ip                    = hiera('nagios_server_ip')
  }


# vim: set ts=2 sw=2 et :
