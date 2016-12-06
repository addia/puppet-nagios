# == Class nagios::service
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
class nagios::service (
  $package_name  = $nagios::params::package_name

  ) inherits nagios::params {
  
  notify { "## --->>> Configuring service for: ${package_name}": } ~>

  service { 'nagios':
    ensure       => running,
    enable       => true,
    }

  service { 'npcd':
    ensure       => running,
    enable       => true,
    }

  service { 'php-fpm':
    ensure       => running,
    enable       => true,
    }

  }


# vim: set ts=2 sw=2 et :
