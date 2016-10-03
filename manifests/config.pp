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
  $base_dir                            = $nagios::params::base_dir,
  $commands_dir                        = $nagios::params::commands_dir,
  $servers_dir                         = $nagios::params::servers_dir,
  $services_dir                        = $nagios::params::services_dir
  ) inherits nagios::params {

  notify { "## --->>> This is the complete config for: ${package_name}": }

  exec { "fix_the_hostname_pants":
    command                            => "cat /etc/hosts | tr [:upper:] [:lower:] > /tmp/hh; mv -f /tmp/hh /etc/hosts",
    onlyif                             => "grep -v '^#' /etc/hosts | grep -q -e '[[:upper:]]'",
    path                               => "/sbin:/bin:/usr/sbin:/usr/bin",
    }

  # put the commands for email and graphing in place
  file { "${base_dir}/commands.cfg":
    ensure                             => file,
    owner                              => 'root',
    group                              => 'root',
    mode                               => '0644',
    source                             => "puppet:///modules/nagios/commands.cfg"
    }

  # put to the timeperiods for alerting in place
  file { "${base_dir}/timeperiods.cfg":
    ensure                             => file,
    owner                              => 'root',
    group                              => 'root',
    mode                               => '0644',
    source                             => "puppet:///modules/nagios/timeperiods.cfg"
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

  # add commands configuration.
  include nagios::config::commands

  # add contacts configuration.
  include nagios::config::contacts

  # add servers configuration.
  include nagios::config::servers

  # add services configuration.
  include nagios::config::services

  }


# via: set ts=2 sw=2 et :
