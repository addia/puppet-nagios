# == Class nagios::config
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
class nagios::config (
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

  notify { "## --->>> This module prepares the ${config_dir} for: ${package_name}": }

  exec { 'manage_config_files' :
    command                            => "mv cgi.cfg.sample cgi.cfg; mv nagios.cfg.sample nagios.cfg",
    cwd                                => '/etc/nagios',
    creates                            => "/etc/nagios/nagios.cfg",
    path                               => "/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin",
    } ~>

  exec { 'backup_config_files' :
    command                            => "cp -p cgi.cfg cgi.cfg.bak; cp -p nagios.cfg nagios.cfg.bak",
    cwd                                => '/etc/nagios',
    creates                            => "/etc/nagios/nagios.cfg.bak",
    path                               => "/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin",
    } ~>

  exec { 'manage_private_config' :
    command                            => "mv resource.cfg.sample private/resource.cfg",
    cwd                                => '/etc/nagios',
    creates                            => "/etc/nagios/private/resource.cfg",
    path                               => "/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin",
    }

  class create_standard_file {

    File {
      ensure                           => 'present',
      owner                            => 'root',
      group                            => 'root',
      mode                             => '0644',
      replace                          => true,
      }

    # put the commands for notification and graphing in place
    file { "${base_dir}/commands.cfg":
      source                           => "puppet:///modules/nagios/commands.cfg"
      }

    # put to the timeperiods for alerting in place
    file { "${base_dir}/timeperiods.cfg":
      source                           => "puppet:///modules/nagios/timeperiods.cfg"
      }
    }

  }


# via: set ts=2 sw=2 et :
