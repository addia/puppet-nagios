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

  $package_name         = 'nagios'
  $user                 = 'nagios'
  $group                = 'nagios'
  $userid               = '240'
  $grpuid               = '240'
  $admin_passwd         = '$apr1$Gb.grQs0$8BKaD0GmU7jmFCpWkbmr70'  # nagiosadmin
  $readonly_passwd      = '$apr1$91LBiouD$gjtlp.5IkEUbhPOyLTkie/'  # nagiosview
  $notification_email   = 'addi.abel@gmail.com'
  $nagios_email         = 'nagios@abel.network'
  $pager_email          = 'nagios@abel.network'
  $nagios_server        = $::fqdn
  $nagios_server_ip     = $::ipaddress
  $purge_unmanaged      = false

  case $::osfamily {
    'ArchLinux': {
      $home_dir         = '/var/nagios/spool'
      $config_dir       = '/etc/nagios'
      $private_dir      = "$config_dir/private"
      $objects_dir      = "$config_dir/objects"
      $commands_dir     = "$objects_dir/commands"
      $servers_dir      = "$objects_dir/servers"
      $services_dir     = "$objects_dir/services"
      $plugin_dir       = '/usr/lib/monitoring-plugins'
      $nagios_logdir    = '/var/nagios'
      $nagios_cmd       = "$nagios_logdir/rw"
      $perfdata_perl    = '/usr/lib/pnp4nagios'
      $perfdata_dir     = '/var/lib/pnp4nagios'
      $perfdata_spool   = "$perfdata_dir/spool"
      $perfdata_base    = "$perfdata_dir/perfdata"
      $doc_root_dir     = "/usr/share/nagios/share"
      }
    'RedHat': {
      $home_dir         = '/var/spool/nagios'
      $config_dir       = '/etc/nagios'
      $private_dir      = "$config_dir/private"
      $objects_dir      = "$config_dir/objects"
      $commands_dir     = "$objects_dir/commands"
      $servers_dir      = "$objects_dir/servers"
      $services_dir     = "$objects_dir/services"
      $plugin_dir       = '/usr/lib64/nagios/plugins'
      $nagios_logdir    = '/var/log/nagios'
      $nagios_cmd       = "$home_dir/cmd"
      $perfdata_perl    = '/usr/libexec/pnp4nagios'
      $perfdata_spool   = '/var/spool/pnp4nagios'
      $perfdata_dir     = '/var/lib/pnp4nagios'
      $perfdata_log     = '/var/log/pnp4nagios'
      $perfdata_base    = "$perfdata_dir/perfdata.dump"
      $doc_root_dir     = "/usr/share/nagios/html"
      }
    }
  }


# vim: set ts=2 sw=2 et : 
