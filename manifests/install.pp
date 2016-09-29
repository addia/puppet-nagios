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
  $package_name                        = $nagios::params::package_name
  ) inherits nagios::params {

  notify { "## --->>> Installing server package: ${package_name}": }

  $packages                            = ['nagios','pnp4nagios']
  package { $packages :
    ensure                             => 'latest',
    }

  }


# vim: set ts=2 sw=2 et :
