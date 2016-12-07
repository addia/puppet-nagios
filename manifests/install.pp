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
      $packages    = ['nagios','pnp4nagios','fcgi-devel','spawn-fcgi','libev']
      }
    'Debian': {
      $packages    = ['nagios','pnp4nagios','apache2-utils','build-essential','spawn-fcgi','fcgiwrap']
      }
    'Archlinux': {
      $packages    = ['nagios','pnp4nagios','fcgiwrap','spawn-fcgi']
      }
    default: {
      fail ( "OS family ${::osfamily} not supported" )
      }
    }
  package { $packages:
    ensure         => 'latest',
    }

  # install fast-cgi stuff ...
  case $::osfamily {
    'RedHat': { 
      file { '/usr/local/sbin/fcgiwrap':
        ensure  => 'present',
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        source  => "puppet:///modules/nagios/fcgiwrap",
      } 
      file { '/usr/local/sbin/multiwatch':
        ensure  => 'present',
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        source  => "puppet:///modules/nagios/multiwatch",
      } 
      file { '/etc/sysconfig/spawn-fcgi':
        ensure  => 'present',
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        replace => true,
        source  => "puppet:///modules/nagios/spawn-fcgi.redhat",
      } 
      # put the service files for fcgi in place:
      systemd::unit_file { 'fcgiwrap.service':
        source  => "puppet:///modules/nagios/fcgiwrap.service.redhat",
      }
      selinux::port { 'allow_nginx_php':
        context                => 'http_port_t',
        port                   => 9009,
        protocol               => 'tcp',
      }
      selinux::port { 'allow_nginx_fcgi':
        context                => 'http_port_t',
        port                   => 9090,
        protocol               => 'tcp',
      }
    }
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
