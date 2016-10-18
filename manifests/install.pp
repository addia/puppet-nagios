# == Class nagios::install
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
class nagios::install (
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

  notify { "## --->>> Installing server package: ${package_name}": }

  $packages                            = ['nagios','pnp4nagios']
  package { $packages :
    ensure                             => 'latest',
    }


  # create the object directories
  notify { "## --->>> creating the ${base_dir}": }
  file { $base_dir:
    ensure                             => directory,
    owner                              => 'root',
    group                              => 'root',
    mode                               => '0755',
    }

  notify { "## --->>> creating the ${private_dir}": }
  file { $private_dir:
    ensure                             => directory,
    owner                              => 'root',
    group                              => 'root',
    mode                               => '0755',
    }

  notify { "## --->>> creating the ${commands_dir}": }
  file { $commands_dir:
    ensure                             => directory,
    owner                              => 'root',
    group                              => 'root',
    mode                               => '0755',
    }

  notify { "## --->>> creating the ${servers_dir}": }
  file { $servers_dir:
    ensure                             => directory,
    owner                              => 'root',
    group                              => 'root',
    mode                               => '0755',
    }

  notify { "## --->>> creating the ${services_dir}": }
  file { $services_dir:
    ensure                             => directory,
    owner                              => 'root',
    group                              => 'root',
    mode                               => '0755',
    }

  }


# vim: set ts=2 sw=2 et :
