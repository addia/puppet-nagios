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
#   Explanation of what the parameteasr are and what the defaults are:
#     package_name                     = the package name
#     user                             = run as user
#     group                            = run as group
#     userid                           = default uid
#     grpuid                           = default gid
#     admin_user                       = the admin user
#     readonly_user                    = the read-only user
#     admin_passwd                     = the admin password
#     readonly_passwd                  = the read-only password
#     notification_email               = email address for notifications
#     nagios_email                     = nagios sending email address
#     pager_email                      = pager email address for notifications
#     nagios_server                    = the server fqdn
#     nagios_server_ip                 = the server ip
#     purge_unmanaged                  = set to false
#     cgi_base_url                     = web server location    *** there has to be a "/" as the last character !!! ***
#
#   The next variables as distribution dependent:
#     home_dir                         = nagios home directory
#     config_dir                       = nagios config config directory
#     private_dir                      = nagios privileges direcory
#     objects_dir                      = nagios base config directory
#     commands_dir                     = the commands directory
#     servers_dir                      = the servers directory
#     services_dir                     = the services directory
#     plugin_dir                       = the plug-in location
#     nagios_logdir                    = the log file location
#     nagios_cmd                       = the command file location
#     perfdata_perl                    = location of the perl modules to create performance data
#     perfdata_spool                   = storage for performance data files
#     doc_root_dir                     = document root directory
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
  $admin_user                          = $nagios::params::admin_user,
  $readonly_user                       = $nagios::params::readonly_user,
  $admin_passwd                        = $nagios::params::admin_passwd,
  $readonly_passwd                     = $nagios::params::readonly_passwd,
  $notification_email                  = $nagios::params::notification_email,
  $nagios_email                        = $nagios::params::nagios_email,
  $pager_email                         = $nagios::params::pager_email,
  $nagios_server                       = $nagios::params::nagios_server,
  $nagios_server_ip                    = $nagios::params::nagios_server_ip,
  $purge_unmanaged                     = $nagios::params::purge_unmanaged,
  $cgi_base_url                        = $nagios::params::cgi_base_url,
  $home_dir                            = $nagios::params::home_dir,
  $config_dir                          = $nagios::params::config_dir,
  $private_dir                         = $nagios::params::private_dir,
  $objects_dir                         = $nagios::params::objects_dir,
  $commands_dir                        = $nagios::params::commands_dir,
  $servers_dir                         = $nagios::params::servers_dir,
  $services_dir                        = $nagios::params::services_dir,
  $plugin_dir                          = $nagios::params::plugin_dir,
  $nagios_logdir                       = $nagios::params::nagios_logdir,
  $nagios_cmd                          = $nagios::params::nagios_cmd,
  $perfdata_perl                       = $nagios::params::perfdata_perl,
  $perfdata_spool                      = $nagios::params::perfdata_spool,
  $doc_root_dir                        = $nagios::params::doc_root_dir,

  ) inherits nagios::params {

    notify { "## --->>> Install and configure ${package_name} server": }

    anchor { 'nagios::begin': } ->
    class { '::nagios::install': } ->
    class { '::nagios::config': } ->
    class { '::nagios::accounts': } ->
    class { '::nagios::setup': } ->
    class { '::nagios::php': } ->
    class { '::nagios::commands': } ->
    class { '::nagios::contacts': } ->
    class { '::nagios::housekeep': } ->
    class { '::nagios::servers': } ->
    class { '::nagios::services': } ->
    class { '::nagios::service': } ->
    anchor { 'nagios::end': }

  }


# vim: set ts=2 sw=2 et :
