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
class nagios::housekeep {

  notify { "## --->>> Removing unwanted config files for: ${package_name}": }

  # remove unwanted files ...
  file { "${base_dir}/printer.cfg":
    ensure                             => 'absent',
    }

  file { "${base_dir}/switch.cfg":
    ensure                             => 'absent',
    }

  file { "${base_dir}/windows.cfg":
    ensure                             => 'absent',
    }

  file { "${base_dir}/localhost.cfg":
    ensure                             => 'absent',
    }

  file { "${base_dir}/templates.cfg":
    ensure                             => 'absent',
    }

  }


# vim: set ts=2 sw=2 et :
