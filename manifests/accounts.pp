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

  # create the user
  group { $group :
    ensure          => present,
    gid             => $grpuid,
    }
  user { $user :
    ensure          => present,
    uid             => $userid,
    gid             => $grpuid,
    home            => $home_dir,
    managehome      => true,
    password        => '!',
    require         => Group["$group"]
  }

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

  }


# vim: set ts=2 sw=2 et :
