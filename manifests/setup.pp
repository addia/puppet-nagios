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
  $admin_user    = $nagios::params::admin_user,
  $readonly_user = $nagios::params::readonly_user,
  $cgi_base_url  = $nagios::params::cgi_base_url,
  $home_dir      = $nagios::params::home_dir,
  $objects_dir   = $nagios::params::objects_dir,
  $private_dir   = $nagios::params::private_dir,
  $nagios_logdir = $nagios::params::nagios_logdir,
  $nagios_cmd    = $nagios::params::nagios_cmd,
  $plugin_dir    = $nagios::params::plugin_dir,
  $config_dir    = $nagios::params::config_dir,
  $doc_root_dir  = $nagios::params::doc_root_dir,

  ) inherits nagios::params {

  notify { "## --->>> Updating the nagios config files for: ${package_name}": }

  # ensure the run directory is there
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

  # put the php config file for nagios in place:
  file { "${doc_root_dir}/config.inc.php":
    ensure       => 'file',
    path         => "${doc_root_dir}/config.inc.php",
    owner        => 'root',
    group        => 'root',
    mode         => '0644',
    replace      => true,
    content      => template('nagios/config.inc.php.erb'),
    notify       => Service['nagios']
    }

  # put the cgi config file for nagios in place:
  file { "${config_dir}/cgi.cfg":
    ensure       => 'file',
    path         => "${config_dir}/cgi.cfg",
    owner        => 'root',
    group        => 'root',
    mode         => '0664',
    replace      => true,
    content      => template('nagios/cgi.cfg.erb'),
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
    content      => template('nagios/nagios.conf.erb')
    }

  # put the service file for nagios in place:
  systemd::unit_file { 'nagios.service':
    content      => template('nagios/nagios.service.erb'),
    }

  }


# vim: set ts=2 sw=2 et :
