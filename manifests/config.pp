# == Class nagios::config
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
class nagios::config (
  $package_name                        = $nagios::params::package_name,
  $user                                = $nagios::params::user,
  $group                               = $nagios::params::group,
  ) inherits nagios::params {

  notify { "## --->>> Updating config files for: ${package_name}": }

  exec { "fix_the_hostname_pants":
    command                            => "cat /etc/hosts | tr [:upper:] [:lower:] > /tmp/hh; mv -f /tmp/hh /etc/hosts",
    onlyif                             => "grep -v '^#' /etc/hosts | grep -q -e '[[:upper:]]'",
    path                               => "/sbin:/bin:/usr/sbin:/usr/bin",
    }

  # add the users to the /etc/nagios/passwd file
  htpasswd { 'nagiosadmin':
    cryptpasswd                        => '$apr1$6JKsZ.Ft$bVDJbTOCqakLOfh5azDAq.',
	target                             => '/etc/nagios/passwd',
    }

  htpasswd { 'nagiosviewer':
    cryptpasswd                        => '$apr1$MUBH5EW.$m7JlU81PTUMrjsrCDiS7J1',
	target                             => '/etc/nagios/passwd',
    }

  # add another user to the /etc/nagios/cgi.cfg config.
  file_line { 'cgi.conf-1':
    ensure                             => 'present',
    path                               => '/etc/nagios/cgi.cfg',
    line                               => 'authorized_for_all_services=nagiosadmin,nagiosview',
    match                              => '^authorized_for_all_services=',
    }

  file_line { 'cgi.conf-2':
    ensure                             => 'present',
    path                               => '/etc/nagios/cgi.cfg',
    line                               => 'authorized_for_all_hosts=nagiosadmin,nagiosview',
    match                              => '^authorized_for_all_hosts=',
    }

  # modify the /etc/nagios/nagios.cfg config.
  file_line { 'nagios.conf-1':
    ensure                             => 'absent',
    path                               => '/etc/nagios/nagios.cfg',
    line                               => '#cfg_file=',
    match                              => '^cfg_file=',
    multiple                           => true,
    }

  file_line { 'nagios.conf-2':
    ensure                             => 'present',
    path                               => '/etc/nagios/nagios.cfg',
    line                               => 'cfg_dir=/etc/nagios/objects',
    match                              => '^cfg_dir=/etc/nagios/conf.d',
    }

  file_line { 'nagios.conf-3':
    ensure                             => 'present',
    path                               => '/etc/nagios/nagios.cfg',
    line                               => 'date_format=strict-iso8601',
    match                              => '^date_format=us',
    }

  file_line { 'nagios.conf-4':
    ensure                             => 'present',
    path                               => '/etc/nagios/nagios.cfg',
    line                               => 'process_performance_data=1',
    match                              => '^process_performance_data=0',
    }

  file_line { 'nagios.conf-5':
    ensure                             => 'present',
    path                               => '/etc/nagios/nagios.cfg',
    line                               => 'host_perfdata_command=process-host-perfdata',
    match                              => '^#host_perfdata_command=process-host-perfdata',
    }

  file_line { 'nagios.conf-6':
    ensure                             => 'present',
    path                               => '/etc/nagios/nagios.cfg',
    line                               => 'service_perfdata_command=process-service-perfdata',
    match                              => '^#service_perfdata_command=process-service-perfdata',
    }

  file_line { 'nagios.conf-7':
    ensure                             => 'present',
    path                               => '/etc/nagios/nagios.cfg',
    line                               => 'host_perfdata_file=/var/log/nagios/host-perfdata',
    match                              => '^#host_perfdata_file=/var/log/nagios/host-perfdata',
    }

  file_line { 'nagios.conf-8':
    ensure                             => 'present',
    path                               => '/etc/nagios/nagios.cfg',
    line                               => 'service_perfdata_file=/var/log/nagios/service-perfdata',
    match                              => '^#service_perfdata_file=/var/log/nagios/service-perfdata',
    }

  file_line { 'nagios.conf-9':
    ensure                             => 'present',
    path                               => '/etc/nagios/nagios.cfg',
    line                               => 'host_perfdata_file_template=[HOSTPERFDATA]\t$TIMET$\t$HOSTNAME$\t$HOSTEXECUTIONTIME$\t$HOSTOUTPUT$\t$HOSTPERFDATA$',
    match                              => '^#host_perfdata_file_template=[HOSTPERFDATA]\t$TIMET$\t$HOSTNAME$\t$HOSTEXECUTIONTIME$\t$HOSTOUTPUT$\t$HOSTPERFDATA$',
    }

  file_line { 'nagios.conf-10':
    ensure                             => 'present',
    path                               => '/etc/nagios/nagios.cfg',
    line                               => 'service_perfdata_file_template=[SERVICEPERFDATA]\t$TIMET$\t$HOSTNAME$\t$SERVICEDESC$\t$SERVICEEXECUTIONTIME$\t$SERVICELATENCY$\t$SERVICEOUTPUT$\t$SERVICEPERFDATA$',
    match                              => '^#service_perfdata_file_template=[SERVICEPERFDATA]\t$TIMET$\t$HOSTNAME$\t$SERVICEDESC$\t$SERVICEEXECUTIONTIME$\t$SERVICELATENCY$\t$SERVICEOUTPUT$\t$SERVICEPERFDATA$',
    }

  file_line { 'nagios.conf-11':
    ensure                             => 'present',
    path                               => '/etc/nagios/nagios.cfg',
    line                               => 'host_perfdata_file_mode=a',
    match                              => '^#host_perfdata_file_mode=a',
    }

  file_line { 'nagios.conf-12':
    ensure                             => 'present',
    path                               => '/etc/nagios/nagios.cfg',
    line                               => 'service_perfdata_file_mode=a',
    match                              => '^#service_perfdata_file_mode=a',
    }

  file_line { 'nagios.conf-13':
    ensure                             => 'present',
    path                               => '/etc/nagios/nagios.cfg',
    line                               => 'host_perfdata_file_processing_interval=15',
    match                              => '^#host_perfdata_file_processing_interval=0',
    }

  file_line { 'nagios.conf-14':
    ensure                             => 'present',
    path                               => '/etc/nagios/nagios.cfg',
    line                               => 'service_perfdata_file_processing_interval=15',
    match                              => '^#service_perfdata_file_processing_interval=0',
    }

  file_line { 'nagios.conf-15':
    ensure                             => 'present',
    path                               => '/etc/nagios/nagios.cfg',
    line                               => 'host_perfdata_file_processing_command=process-host-perfdata-file',
    match                              => '^#host_perfdata_file_processing_command=process-host-perfdata-file',
    }

  file_line { 'nagios.conf-16':
    ensure                             => 'present',
    path                               => '/etc/nagios/nagios.cfg',
    line                               => 'service_perfdata_file_processing_command=process-service-perfdata-file',
    match                              => '^#service_perfdata_file_processing_command=process-service-perfdata-file',
    }

  file_line { 'nagios.conf-17':
    ensure                             => 'present',
    path                               => '/etc/nagios/nagios.cfg',
    line                               => 'host_perfdata_process_empty_results=1',
    match                              => '^#host_perfdata_process_empty_results=1',
    }

  file_line { 'nagios.conf-18':
    ensure                             => 'present',
    path                               => '/etc/nagios/nagios.cfg',
    line                               => 'service_perfdata_process_empty_results=1',
    match                              => '^#service_perfdata_process_empty_results=1',
    }

  # deploy the config files:
  git::reposync { 'server_stuff':
    source_url                         => 'http://192.168.249.38/webops/puppet-nagios.git',
    destination_dir                    => '/etc/nagios/',
    }

  # remove unwanted files ...
  file { '/etc/nagios/objects/printer.cfg':
    ensure                             => 'absent',
    }

  file { '/etc/nagios/objects/switch.cfg':
    ensure                             => 'absent',
    }

  file { '/etc/nagios/objects/windows.cfg':
    ensure                             => 'absent',
    }

  }


# via: set ts=2 sw=2 et :
