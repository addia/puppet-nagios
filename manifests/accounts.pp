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
  $package_name     = $nagios::params::package_name,
  $user             = $nagios::params::user,
  $group            = $nagios::params::group,
  $uid              = $nagios::params::uid,
  $guid             = $nagios::params::guid,
  $home_dir         = $nagios::params::home_dir,
  $config_dir       = $nagios::params::config_dir,
  $admin_passwd     = $nagios::params::admin_passwd,
  $readonly_passwd  = $nagios::params::readonly_passwd

  ) inherits nagios::params  {

  notify { "## --->>> Updating the user config files for: ${package_name}": }

  # add the users to the passwd file
  htpasswd { 'nagiosadmin':
    cryptpasswd     => $admin_passwd,
    target          => "${config_dir}/passwd",
    }

  htpasswd { 'nagiosview':
    cryptpasswd     => $readonly_passwd,
    target          => "${config_dir}/passwd",
    }

  file { "${config_dir}/passwd":
    owner           => 'root',
    group           => $group,
    mode            => 640,
    }

  # allow nginx to read nagios files
  exec {"allow nginx access to nagios":
    unless          => "/bin/grep nagios /etc/group | /bin/cut -d: -f4 | /bin/grep -q nginx",
    command         => "/bin/gpasswd -a nginx nagios",
    require         => Package['nginx'],
    }

  }


# vim: set ts=2 sw=2 et :
