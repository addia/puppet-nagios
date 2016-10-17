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

  class create_standard_directories {

    File {
      ensure                           => 'present',
      owner                            => 'root',
      group                            => 'root',
      mode                             => '0755',
      }

    # create the object directories
    file { $base_dir:
      ensure                           => directory,
      }

    file { $private_dir:
      ensure                           => directory,
      }

    file { $commands_dir:
      ensure                           => directory,
      }

    file { $servers_dir:
      ensure                           => directory,
      }

    file { $services_dir:
      ensure                           => directory,
      }

    }

  }


# vim: set ts=2 sw=2 et :
