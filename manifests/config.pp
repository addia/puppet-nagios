# == Class nagios::config
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
class nagios::config (
  $package_name                        = $nagios::params::package_name,
  $user                                = $nagios::params::user,
  $group                               = $nagios::params::group,
  ) inherits nagios::params {

  notify { "## --->>> Updating all the config files for: ${package_name}": }

  exec { "fix_the_hostname_pants":
    command                            => "cat /etc/hosts | tr [:upper:] [:lower:] > /tmp/hh; mv -f /tmp/hh /etc/hosts",
    onlyif                             => "grep -v '^#' /etc/hosts | grep -q -e '[[:upper:]]'",
    path                               => "/sbin:/bin:/usr/sbin:/usr/bin",
    }

  # add the users to the /etc/nagios/passwd file
  include nagios::config::user

  # modify the /etc/nagios/cgi.cfg config.
  include nagios::config::cgi

  # modify the /etc/nagios/nagios.cfg config.
  include nagios::config::main

  # remove redundant files.
  include nagios::config::files

  # add configuration directories.
  include nagios::config::dirs

  }


# via: set ts=2 sw=2 et :
