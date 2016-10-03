# == Class nagios::config::cgi
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
class nagios::config::cgi (
  $package_name                        = $nagios::params::package_name,
  ) inherits nagios::params {

  notify { "## --->>> Updating the cgi config files for: ${package_name}": }


  # add another user to the /etc/nagios/cgi.cfg config.
  file_line { 'cgi.conf-1':
    ensure                             => 'present',
    path                               => '/etc/nagios/cgi.cfg',
    line                               => 'authorized_for_all_services=nagiosadmin,nagiosview',
    match                              => '^authorized_for_all_services=',
    }

  file_line { 'cgi.conf-2':
    ensure                             => 'present',
    path                               => '/etc/nagios/cgi.cfg',
    line                               => 'authorized_for_all_hosts=nagiosadmin,nagiosview',
    match                              => '^authorized_for_all_hosts=',
    }

  }


# vim: set ts=2 sw=2 et :
