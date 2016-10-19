# == Class nagios::housekeep
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
class nagios::housekeep (
  $package_name                        = $nagios::params::package_name,
  $objects_dir                         = $nagios::params::objects_dir,

  ) inherits nagios::params {

  notify { "## --->>> Removing unwanted config files for: ${package_name}": }

  # remove unwanted files ...
  file { "${objects_dir}/printer.cfg":
    ensure                             => 'absent',
    }

  file { "${objects_dir}/switch.cfg":
    ensure                             => 'absent',
    }

  file { "${objects_dir}/windows.cfg":
    ensure                             => 'absent',
    }

  file { "${objects_dir}/localhost.cfg":
    ensure                             => 'absent',
    }

  file { "${objects_dir}/templates.cfg":
    ensure                             => 'absent',
    }

  }


# vim: set ts=2 sw=2 et :
