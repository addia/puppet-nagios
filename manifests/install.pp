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
  $group                               = $nagios::params::group,
  $objects_dir                         = $nagios::params::objects_dir,
  $private_dir                         = $nagios::params::private_dir,
  $config_dir                          = $nagios::params::config_dir,
  $commands_dir                        = $nagios::params::commands_dir,
  $servers_dir                         = $nagios::params::servers_dir,
  $services_dir                        = $nagios::params::services_dir,
  $plugin_dir                          = $nagios::params::plugin_dir,

  ) inherits nagios::params {

  notify { "## --->>> Installing server package: ${package_name}": }

  #$packages                           = ['nagios','pnp4nagios','nginx','php5-fpm','apache2-utils','build-essential','spawn-fcgi','fcgiwrap']
  $packages                            = ['nagios','pnp4nagios']
  package { $packages :
    ensure                             => 'latest',
    }


  # create the objects directories
  notify { "## --->>> creating the ${objects_dir}": }
  file { $objects_dir:
    ensure                             => directory,
    owner                              => 'root',
    group                              => $group,
    mode                               => '0750',
    }

  notify { "## --->>> creating the ${private_dir}": }
  file { $private_dir:
    ensure                             => directory,
    owner                              => 'root',
    group                              => $group,
    mode                               => '0750',
    }

  notify { "## --->>> creating the ${commands_dir}": }
  file { $commands_dir:
    ensure                             => directory,
    owner                              => 'root',
    group                              => $group,
    mode                               => '0750',
    }

  notify { "## --->>> creating the ${servers_dir}": }
  file { $servers_dir:
    ensure                             => directory,
    owner                              => 'root',
    group                              => $group,
    mode                               => '0750',
    }

  notify { "## --->>> creating the ${services_dir}": }
  file { $services_dir:
    ensure                             => directory,
    owner                              => 'root',
    group                              => $group,
    mode                               => '0750',
    }

  notify { "## --->>> creating the ${plugin_dir}": }
  file { $plugin_dir:
    ensure                             => directory,
    owner                              => 'root',
    group                              => $group,
    mode                               => '0750',
    }

  }


# vim: set ts=2 sw=2 et :
