# == Class nagios::config::files
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
class nagios::config::files (
  $package_name                        = $nagios::params::package_name,
  ) inherits nagios::params {

  notify { "## --->>> Removing unwanted config files for: ${package_name}": }

  # remove unwanted files ...
  file { '/etc/nagios/objects/printer.cfg':
    ensure                             => 'absent',
    }

  file { '/etc/nagios/objects/switch.cfg':
    ensure                             => 'absent',
    }

  file { '/etc/nagios/objects/windows.cfg':
    ensure                             => 'absent',
    }

  file { '/etc/nagios/objects/localhost.cfg':
    ensure                             => 'absent',
    }

  file { '/etc/nagios/objects/template.cfg':
    ensure                             => 'absent',
    }

  }


# via: set ts=2 sw=2 et :
