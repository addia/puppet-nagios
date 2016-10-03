# == Class nagios::config::services
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
class nagios::config::services (
  $package_name                        = $nagios::params::package_name,
  $services_dir                        = $nagios::params::services_dir,
  ) inherits nagios::params {

  notify { "## --->>> Adding manitoring services for: ${package_name}": }

  # manage the nagios monitoring servicegroups
  nagios_servicegroup { 'all-services':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${services_dir}/service_groups.cfg",
    servicegroup_members               => 'production-service, database-service, web-service',
    alias                              => 'All Services',
    }

  nagios_servicegroup { 'production-service':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${services_dir}/service_groups.cfg",
    alias                              => 'Production Services',
    }

  nagios_servicegroup { 'database-service':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${services_dir}/service_groups.cfg",
    alias                              => 'Database Services',
    }

  nagios_servicegroup { 'web-service':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${services_dir}/service_groups.cfg",
    alias                              => 'Web Services',
    }

  # manage the nagios monitoring services
  nagios_service { 'service-cpu':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${services_dir}/service_cpu.cfg",
    service_description                => 'Server CPU',
    use                                => 'generic-service,service-graph',
    hostgroup_name                     => 'linux-servers',
    servicegroups                      => 'all-services',
    check_command                      => 'check_cpu',
    }

  # service templates
  nagios_service { 'generic-service':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${services_dir}/service_generic.cfg",
    active_checks_enabled              => '1',
    passive_checks_enabled             => '1',
    parallelize_check                  => '1',
    obsess_over_service                => '1',
    check_freshness                    => '0',
    notifications_enabled              => '1',
    event_handler_enabled              => '1',
    flap_detection_enabled             => '1',
    process_perf_data                  => '1',
    retain_status_information          => '1',
    retain_nonstatus_information       => '1',
    is_volatile                        => '0',
    check_period                       => '24x7',
    max_check_attempts                 => '5',
    normal_check_interval              => '10',
    retry_check_interval               => '3',
    contact_groups                     => 'admins',
    notification_options               => 'w,u,c,r',
    notification_interval              => '60',
    notification_period                => '24x7',
    register                           => '0'
    }

  nagios_service{ 'service-graph':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${services_dir}/service_generic.cfg",
    action_url                         => '/pnp4nagios/index.php/graph?host=$HOSTNAME$&srv=$SERVICEDESC$',
    register                           => '0'
    }
  }


# vim: set ts=2 sw=2 et :
