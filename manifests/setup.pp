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
  $plugin_dir    = $nagios::params::plugin_dir,
  $config_dir    = $nagios::params::config_dir

  ) inherits nagios::params {

  notify { "## --->>> Updating the nagios config files for: ${package_name}": }

  file { '/var/run/nagios':
    ensure       => 'directory',
    owner        => $user,
    group        => $group,
    mode         => '0755',
    }

  # put the main config file for nagios in place:
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

  # put the secrets file for nagios in place:
  file { "${private_dir}/resource.cfg":
    ensure       => 'file',
    path         => "${private_dir}/resource.cfg",
    owner        => 'root',
    group        => $group,
    mode         => '0640',
    replace      => true,
    content      => template('nagios/resource.cfg.erb'),
    notify       => Service['nagios']
    }

  # put the pid config file for nagios in place:
  file { '/usr/lib/tmpfiles.d/nagios.conf':
    ensure       => 'file',
    path         => '/usr/lib/tmpfiles.d/nagios.conf',
    owner        => 'root',
    group        => 'root',
    mode         => '0644',
    replace      => true,
    content      => template('nagios/nagios.conf.erb'),
    notify       => Service['nagios']
    }

  # put the service file for nagios in place:
  systemd::unit_file { 'nagios.service':
    content      => template('nagios/nagios.service.erb'),
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

  class { 'phpfpm':
    poold_purge => true,
    }

  # Pool running as a different user
  phpfpm::pool { 'nagios':
      listen => '127.0.0.1:9009',
      user   => 'nginx',
      group  => 'nginx',
    }
  }


# vim: set ts=2 sw=2 et :
