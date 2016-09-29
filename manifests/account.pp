# == Class nagios::account
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
class nagios::account (
  $package_name                        = $nagios::params::package_name,
  $user                                = $nagios::params::user,
  $group                               = $nagios::params::group,
  $uid                                 = $nagios::params::uid,
  $guid                                = $nagios::params::guid,
  $home_dir                            = $nagios::params::home_dir
  ) inherits nagios::params {

  notify { "## --->>> Creating accounts for: ${package_name}": }

  group { $group:
    ensure                             => 'present',
    gid                                => $guid
    }

  user { $user: 
    ensure                             => 'present',
    home                               => $home_dir,
    shell                              => '/bin/bash',
    uid                                => $uid,
    gid                                => $guid,
    password                           => '!!',
    managehome                         => true,
    }

  file { '/etc/sudoers.d/20-nagios' :
    ensure                             => file,
    owner                              => 'root',
    group                              => 'root',
    mode                               => '0644',
    source                             => "puppet:///modules/nagios/20-nagios",
    }

  }



# vim: set ts=2 sw=2 et :
