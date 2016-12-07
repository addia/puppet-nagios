# == Class nagios::php
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
class nagios::php (
  $package_name  = $nagios::params::package_name,

  ) inherits nagios::params {

  notify { "## --->>> Updating the nagios php files for: ${package_name}": }

  # put the php config file for nagios in place:
  php::ini { '/etc/php.ini':
    display_errors => 'On',
    memory_limit   => '256M',
    date_timezone  => 'UTC',
    }  

  php::fpm::conf { 'www':
    ensure         => 'absent',
    }

  php::fpm::conf { 'nagios':
    listen         => '127.0.0.1:9001',
    user           => 'nginx',
    group          => 'nginx',
    log_level      => 'warning',
    error_log      => '/var/log/phpfpm.log',
    require        => User['nginx'],
    }

  # allow nginx access php execmem
  case $::osfamily {
    'RedHat': {
      selinux::module { 'nginx_local':
        ensure   => 'present',
        source   => 'puppet:///modules/nagios/nginx.te'
        }
      }
    }
  }


# vim: set ts=2 sw=2 et :
