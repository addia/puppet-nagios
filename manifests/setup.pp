# == Class nagios::setup
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
class nagios::setup (
  $package_name  = $nagios::params::package_name,
  $user          = $nagios::params::user,
  $group         = $nagios::params::group,
  $home_dir      = $nagios::params::home_dir,
  $objects_dir   = $nagios::params::objects_dir,
  $private_dir   = $nagios::params::private_dir,
  $nagios_logdir = $nagios::params::nagios_logdir,
  $nagios_cmd    = $nagios::params::nagios_cmd,
  $config_dir    = $nagios::params::config_dir

  ) inherits nagios::params {

  notify { "## --->>> Updating the nagios config files for: ${package_name}": }

  # put the command file for nagios in place:
  file { "${config_dir}/nagios.cfg":
    ensure       => 'file',
    path         => "${config_dir}/nagios.cfg",
    owner        => 'root',
    group        => 'root',
    mode         => '0664',
    replace      => true,
    content      => template('nagios/nagios.cfg.erb'),
    notify       => Service['nagios']
    }

  notify { "## --->>> Updating the cgi config files for: ${package_name}": }

  # add another user to the /etc/nagios/cgi.cfg config.
  file_line { 'cgi.conf-1':
    ensure       => 'present',
    path         => "${config_dir}/cgi.cfg",
    line         => 'authorized_for_all_services=nagiosadmin,nagiosview',
    match        => '^authorized_for_all_services=',
    }

  file_line { 'cgi.conf-2':
    ensure       => 'present',
    path         => "${config_dir}/cgi.cfg",
    line         => 'authorized_for_all_hosts=nagiosadmin,nagiosview',
    match        => '^authorized_for_all_hosts=',
    }

  }


# vim: set ts=2 sw=2 et :
