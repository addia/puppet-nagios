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

  # directory for log files
  file { '/var/log/php-fpm':
    ensure       => 'directory',
    owner        => 'nginx',
    group        => 'nginx',
    mode         => '0755',
    }

  # put the php config file for nagios in place:
  php::ini { '/etc/php.ini':
    display_errors => 'On',
    memory_limit   => '256M',
    date_timezone  => 'UTC',
    }  

  php::fpm::conf { 'www':
    ensure         => 'absent',
    }

  # allow nginx and nrpe access to system resources
  case $::osfamily {
    'RedHat': {
      php::fpm::conf { 'nagios':
        listen         => '127.0.0.1:9009',
        user           => 'nginx',
        group          => 'nginx',
        error_log      => '/var/log/php-fpm/phpfpm.log',
        require        => Package['nginx'],
        }
      selinux::module { 'nginx_local':
        ensure   => 'present',
        source   => 'puppet:///modules/nagios/nginx.te'
        }
      selinux::module { 'nrpe_local':
        ensure   => 'present',
        source   => 'puppet:///modules/nagios/nrpe.te'
        }
      }
    'Archlinux': {
      php::fpm::conf { 'nagios':
        listen         => '/run/php-fpm/nagios.sock',
        user           => 'nginx',
        group          => 'nginx',
        error_log      => '/var/log/php-fpm/phpfpm.log',
        require        => Package['nginx-mainline-addons'],
        }
      }
    }
  }


# vim: set ts=2 sw=2 et :
