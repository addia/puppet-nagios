# == Class nagios::nginx
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
class nagios::nginx (
  $package_name  = $nagios::params::package_name,

  ) inherits nagios::params {

  notify { "## --->>> Installin the nginx server for: ${package_name}": }

  class { 'nginx':
    log_format      => {
      main          =>  '$http_x_forwarded_for - $remote_addr - $remote_user [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent"'},
    http_format_log => 'main',
    }
  }


# vim: set ts=2 sw=2 et :
