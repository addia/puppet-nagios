# == Class nagios::accounts
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
class nagios::accounts (
  $package_name                        = $nagios::params::package_name,
  $config_dir                          = $nagios::params::config_dir,
  $admin_passwd                        = $nagios::params::admin_passwd,
  $readonly_passwd                     = $nagios::params::readonly_passwd

  ) inherits nagios::params  {

  notify { "## --->>> Updating the user config files for: ${package_name}": }


  # add the users to the passwd file
  htpasswd { 'nagiosadmin':
    cryptpasswd                        => $admin_passwd,
	target                             => "${config_dir}/passwd",
    }

  htpasswd { 'nagiosview':
    cryptpasswd                        => $readonly_passwd,
	target                             => "${config_dir}/passwd",
    }

  }


# vim: set ts=2 sw=2 et :
