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
  $private_dir                         = $nagios::params::private_dir,
  $objects_dir                         = $nagios::params::objects_dir,
  $config_dir                          = $nagios::params::config_dir

  ) inherits nagios::params {

  notify { "## --->>> This module prepares the ${config_dir} for: ${package_name}": }

  exec { 'manage_config_files' :
    command                            => "mv cgi.cfg.sample cgi.cfg; mv nagios.cfg.sample nagios.cfg",
    cwd                                => $config_dir,
    creates                            => "${config_dir}/nagios.cfg",
    path                               => "/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin",
    } ~>

  exec { 'backup_config_files' :
    command                            => "cp -p cgi.cfg cgi.cfg.bak; cp -p nagios.cfg nagios.cfg.bak",
    cwd                                => $config_dir,
    creates                            => "${config_dir}/nagios.cfg.bak",
    path                               => "/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin",
    } ~>

  exec { 'manage_private_config' :
    command                            => "mv resource.cfg.sample ${private_dir}/resource.cfg",
    cwd                                => $config_dir,
    creates                            => "${private_dir}/resource.cfg",
    path                               => "/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin",
    }

  # put the commands for email notification in place
  file { "${objects_dir}/commands.cfg":
    source                             => "puppet:///modules/nagios/commands.cfg",
    ensure                             => 'present',
    owner                              => 'root',
    group                              => 'root',
    mode                               => '0644',
    replace                            => true,
    }

  # put to the timeperiods for alerting in place
  file { "${objects_dir}/timeperiods.cfg":
    source                             => "puppet:///modules/nagios/timeperiods.cfg",
    ensure                             => 'present',
    owner                              => 'root',
    group                              => 'root',
    mode                               => '0644',
    replace                            => true,
    }

  }


# via: set ts=2 sw=2 et :
