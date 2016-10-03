# == Class nagios::config::dirs
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
class nagios::config::dirs (
  $package_name                        = $nagios::params::package_name,
  ) inherits nagios::params {

  notify { "## --->>> Adding config dirs for: ${package_name}": }

  # manage object directories
  file { '/etc/nagios/objects/commands':
    ensure                             => 'directory',
    }

  file { '/etc/nagios/objects/servers':
    ensure                             => 'directory',
    }

  file { '/etc/nagios/objects/services':
    ensure                             => 'directory',
    }

  }


# via: set ts=2 sw=2 et :
