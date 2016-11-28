# == Class nagios::install
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
class nagios::install (
  $package_name    = $nagios::params::package_name,
  $group           = $nagios::params::group,
  $perfdata_spool  = $nagios::params::perfdata_spool,
  $objects_dir     = $nagios::params::objects_dir,
  $private_dir     = $nagios::params::private_dir,
  $config_dir      = $nagios::params::config_dir,
  $commands_dir    = $nagios::params::commands_dir,
  $servers_dir     = $nagios::params::servers_dir,
  $services_dir    = $nagios::params::services_dir,
  $plugin_dir      = $nagios::params::plugin_dir,

  ) inherits nagios::params {

  notify { "## --->>> Installing server package: ${package_name}": }

  case $::osfamily {
    'RedHat': {
      $packages    = ['nagios','pnp4nagios','nginx','php-fpm','fcgi-devel','spawn-fcgi']
      }
    'Debian': {
      $packages    = ['nagios','pnp4nagios','nginx','php5-fpm','apache2-utils','build-essential','spawn-fcgi','fcgiwrap']
      }
    'Archlinux': {
      $packages    = ['nagios','pnp4nagios','nginx-mainline-addons','php-fpm','fcgiwrap','spawn-fcgi']
      }
    default: {
      fail ( "OS family ${::osfamily} not supported" )
      }
    }
  package { $packages:
    ensure         => 'latest',
    }

  # create the objects directories
  notify { "## --->>> creating config directories for ${package_name}": }

  file { $objects_dir:
    ensure         => directory,
    owner          => 'root',
    group          => $group,
    mode           => '0750',
    require        => Package[$packages]
    }

  file { $private_dir:
    ensure         => directory,
    owner          => 'root',
    group          => $group,
    mode           => '0750',
    require        => Package[$packages]
    }

  file { $commands_dir:
    ensure         => directory,
    owner          => 'root',
    group          => $group,
    mode           => '0750',
    require        => File[$objects_dir]
    }

  file { $servers_dir:
    ensure         => directory,
    owner          => 'root',
    group          => $group,
    mode           => '0750',
    require        => File[$objects_dir]
    }

  file { $services_dir:
    ensure         => directory,
    owner          => 'root',
    group          => $group,
    mode           => '0750',
    require        => File[$objects_dir]
    }

  file { $perfdata_spool:
    ensure         => directory,
    owner          => 'root',
    group          => $group,
    mode           => '0775',
    require        => Package[$packages]
    }

  }


# vim: set ts=2 sw=2 et :
