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
  $package_name                        = $nagios::params::package_name,
  $home_dir                            = $nagios::params::home_dir,
  $objects_dir                         = $nagios::params::objects_dir,
  $config_dir                          = $nagios::params::config_dir

  ) inherits nagios::params {

  notify { "## --->>> Updating the nagios config files for: ${package_name}": }

  # modify the /etc/nagios/nagios.cfg config.
  file_line { 'nagios.del-1':
    ensure                             => 'absent',
    path                               => "${config_dir}/nagios.cfg",
    line                               => 'cfg_file=/etc/nagios/objects/templates.cfg',
    match                              => '^cfg_file='
    }

  file_line { 'nagios.del-2':
    ensure                             => 'absent',
    path                               => "${config_dir}/nagios.cfg",
    line                               => 'cfg_file=/etc/nagios/objects/localhost.cfg',
    match                              => '^cfg_file='
    }

  file_line { 'nagios.conf-1':
    ensure                             => 'present',
    path                               => "${config_dir}/nagios.cfg",
    line                               => 'cfg_dir=/etc/nagios/objects/commands',
    match                              => '^cfg_dir=/etc/nagios/conf.d',
    }

  file_line { 'nagios.conf-2':
    ensure                             => 'present',
    path                               => "${config_dir}/nagios.cfg",
    line                               => 'cfg_dir=/etc/nagios/objects/servers',
    after                              => '^#cfg_dir=/etc/nagios/routers',
    }

  file_line { 'nagios.conf-3':
    ensure                             => 'present',
    path                               => "${config_dir}/nagios.cfg",
    line                               => 'cfg_dir=/etc/nagios/objects/services',
    after                              => '^#cfg_dir=/etc/nagios/routers',
    }

  file_line { 'nagios.conf-4':
    ensure                             => 'present',
    path                               => "${config_dir}/nagios.cfg",
    line                               => 'date_format=strict-iso8601',
    match                              => '^date_format=us',
    }

  file_line { 'nagios.conf-5':
    ensure                             => 'present',
    path                               => "${config_dir}/nagios.cfg",
    line                               => 'process_performance_data=1',
    match                              => '^process_performance_data=0',
    }

  file_line { 'nagios.conf-6':
    ensure                             => 'present',
    path                               => "${config_dir}/nagios.cfg",
    line                               => '#host_perfdata_command=process-host-perfdata',
    match                              => '^#host_perfdata_command=process-host-perfdata',
    }

  file_line { 'nagios.conf-7':
    ensure                             => 'present',
    path                               => "${config_dir}/nagios.cfg",
    line                               => '#service_perfdata_command=process-service-perfdata',
    match                              => '^#service_perfdata_command=process-service-perfdata',
    }

  file_line { 'nagios.conf-8':
    ensure                             => 'present',
    path                               => "${config_dir}/nagios.cfg",
    line                               => "host_perfdata_file=${home_dir}/host-perfdata",
    match                              => '^#host_perfdata_file=',
    }

  file_line { 'nagios.conf-9':
    ensure                             => 'present',
    path                               => "${config_dir}/nagios.cfg",
    line                               => "service_perfdata_file=${home_dir}/service-perfdata",
    match                              => '^#service_perfdata_file=',
    }

  file_line { 'nagios.conf-10':
    ensure                             => 'present',
    path                               => "${config_dir}/nagios.cfg",
    line                               => "host_perfdata_file_template=DATATYPE::HOSTPERFDATA\tTIMET::\$TIMET\$\tHOSTNAME::\$HOSTNAME\$\tHOSTPERFDATA::\$HOSTPERFDATA\$\tHOSTCHECKCOMMAND::\$HOSTCHECKCOMMAND\$\tHOSTSTATE::\$HOSTSTATE\$\tHOSTSTATETYPE::\$HOSTSTATETYPE\$",
    match                              => '^#host_perfdata_file_template=',
    }

  file_line { 'nagios.conf-11':
    ensure                             => 'present',
    path                               => "${config_dir}/nagios.cfg",
    line                               => "service_perfdata_file_template=DATATYPE::SERVICEPERFDATA\tTIMET::\$TIMET\$\tHOSTNAME::\$HOSTNAME\$\tSERVICEDESC::\$SERVICEDESC\$\tSERVICEPERFDATA::\$SERVICEPERFDATA\$\tSERVICECHECKCOMMAND::\$SERVICECHECKCOMMAND\$\tHOSTSTATE::\$HOSTSTATE\$\tHOSTSTATETYPE::\$HOSTSTATETYPE\$\tSERVICESTATE::\$SERVICESTATE\$\tSERVICESTATETYPE::\$SERVICESTATETYPE\$",
    match                              => '^#service_perfdata_file_template=',
    }

  file_line { 'nagios.conf-12':
    ensure                             => 'present',
    path                               => "${config_dir}/nagios.cfg",
    line                               => 'host_perfdata_file_mode=a',
    match                              => '^#host_perfdata_file_mode=a',
    }

  file_line { 'nagios.conf-13':
    ensure                             => 'present',
    path                               => "${config_dir}/nagios.cfg",
    line                               => 'service_perfdata_file_mode=a',
    match                              => '^#service_perfdata_file_mode=a',
    }

  file_line { 'nagios.conf-14':
    ensure                             => 'present',
    path                               => "${config_dir}/nagios.cfg",
    line                               => 'host_perfdata_file_processing_interval=15',
    match                              => '^#host_perfdata_file_processing_interval=0',
    }

  file_line { 'nagios.conf-15':
    ensure                             => 'present',
    path                               => "${config_dir}/nagios.cfg",
    line                               => 'service_perfdata_file_processing_interval=15',
    match                              => '^#service_perfdata_file_processing_interval=0',
    }

  file_line { 'nagios.conf-16':
    ensure                             => 'present',
    path                               => "${config_dir}/nagios.cfg",
    line                               => 'host_perfdata_file_processing_command=process-host-perfdata-file',
    match                              => '^#host_perfdata_file_processing_command=process-host-perfdata-file',
    }

  file_line { 'nagios.conf-17':
    ensure                             => 'present',
    path                               => "${config_dir}/nagios.cfg",
    line                               => 'service_perfdata_file_processing_command=process-service-perfdata-file',
    match                              => '^#service_perfdata_file_processing_command=process-service-perfdata-file',
    }

  file_line { 'nagios.conf-18':
    ensure                             => 'present',
    path                               => "${config_dir}/nagios.cfg",
    line                               => 'host_perfdata_process_empty_results=1',
    match                              => '^#host_perfdata_process_empty_results=1',
    }

  file_line { 'nagios.conf-19':
    ensure                             => 'present',
    path                               => "${config_dir}/nagios.cfg",
    line                               => 'service_perfdata_process_empty_results=1',
    match                              => '^#service_perfdata_process_empty_results=1',
    }

  file_line { 'nagios.conf-20':
    ensure                             => 'present',
    path                               => "${config_dir}/nagios.cfg",
    line                               => 'resource_file=/etc/nagios/private/resource.cfg',
    match                              => '^resource_file=/etc/nagios/resource.cfg',
    }

  notify { "## --->>> Updating the cgi config files for: ${package_name}": }

  # add another user to the /etc/nagios/cgi.cfg config.
  file_line { 'cgi.conf-1':
    ensure                             => 'present',
    path                               => "${config_dir}/cgi.cfg",
    line                               => 'authorized_for_all_services=nagiosadmin,nagiosview',
    match                              => '^authorized_for_all_services=',
    }

  file_line { 'cgi.conf-2':
    ensure                             => 'present',
    path                               => "${config_dir}/cgi.cfg",
    line                               => 'authorized_for_all_hosts=nagiosadmin,nagiosview',
    match                              => '^authorized_for_all_hosts=',
    }

  }


# vim: set ts=2 sw=2 et :
