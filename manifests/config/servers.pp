# == Class nagios::config::servers
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
class nagios::config::servers (
  $package_name                        = $nagios::params::package_name,
  $servers_dir                         = $nagios::params::servers_dir,
  ) inherits nagios::params {

  notify { "## --->>> Adding manitoring servers for: ${package_name}": }

  # manage the nagios monitoring hostgroups
  nagios_hostgroup { 'all-servers':
    ensure                             => 'present',
    target                             => "${servers_dir}/host_groups.cfg",
    hostgroup_members                  => 'linux-servers, linux-virtual-servers, web-servers',
    alias                              => 'All Servers'
    }

  nagios_hostgroup { 'linux-servers':
    ensure                             => 'present',
    target                             => "${servers_dir}/host_groups.cfg",
    alias                              => 'Linux Servers'
    }

  nagios_hostgroup { 'linux-virtual-servers':
    ensure                             => 'present',
    target                             => "${servers_dir}/host_groups.cfg",
    alias                              => 'Linux Virtual Servers'
    }

  nagios_hostgroup { 'web-servers':
    ensure                             => 'present',
    target                             => "${servers_dir}/host_groups.cfg",
    alias                              => 'Web Servers'
    }

  # manage the nagios monitoring hosts
  nagios_host { 'host_centos':
    ensure                             => 'present',
    target                             => "${servers_dir}/host_centos.cfg",
    alias                              => 'centos7.abel.uk.com',
    display_name                       => 'Addis CentOS7',
    address                            => '192.168.122.10',
    use                                => 'generic-server,server-graph',
    hostgroups                         => 'linux-servers, linux-virtual-servers',
    contact_groups                     => 'webops',
    notification_period                => '24x7',
    icon_image_alt                     => 'Linux',
    statusmap_image                    => 'vendor-logos/linux.jpg',
    icon_image                         => 'vendor-logos/linux.jpg'
    }

  # server templates
  nagios_host { 'generic-server':
    ensure                             => 'present',
    target                             => "${server_dir}/host_generic.cfg",
    notifications_enabled              => '1',
    event_handler_enabled              => '1',
    flap_detection_enabled             => '1',
    process_perf_data                  => '1',
    retain_status_information          => '1',
    retain_nonstatus_information       => '1',
    check_period                       => '24x7',
    check_interval                     => '5',
    retry_interval                     => '1',
    max_check_attempts                 => '10',
    check_command                      => 'check-host-alive',
    notification_period                => '24x7',
    notification_interval              => '120',
    notification_options               => 'd,u,r,f,s',
    contact_groups                     => 'admins',
    register                           => '0'
    }

  nagios_host { 'generic-graph':
    ensure                             => 'present',
    target                             => "${server_dir}/host_generic.cfg",
    action_url                         => '/pnp4nagios/index.php/graph?host=$HOSTNAME$&srv=_HOST_',
    register                           => '0'
    }

  }


# vim: set ts=2 sw=2 et :
