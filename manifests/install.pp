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
class nagios::install {

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
