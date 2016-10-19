# == Class nagios::commands
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
class nagios::commands (
  $package_name                        = $nagios::params::package_name,
  $perfdata_perl                       = $nagios::params::perfdata_perl,
  $perfdata_spool                      = $nagios::params::perfdata_spool,
  $commands_dir                        = $nagios::params::commands_dir,

  ) inherits nagios::params {

  notify { "## --->>> Adding manitoring commands for: ${package_name}": }

  # manage the nagios monitoring commands
  nagios_command { 'check_host_alive':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${commands_dir}/check_ping.cfg",
    command_line                       => '$USER1$/check_ping -H \'$HOSTADDRESS$\' -w 3000.0,80% -c 5000.0,100% -p 5'
    }

  nagios_command { 'check_ping':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${commands_dir}/check_ping.cfg",
    command_line                       => '$USER1$/check_ping -H \'$HOSTADDRESS$\' -w \'$ARG1$\' -c \'$ARG2$\' -p 5'
    }

  nagios_command { 'check_cpu':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${commands_dir}/check_cpu.cfg",
    command_line                       => '$USER1$/check_nrpe -H \'$HOSTADDRESS$\' -c check_linux_cpu'
    }

  nagios_command { 'check_disk':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${commands_dir}/check_disk.cfg",
    command_line                       => '$USER1$/check_nrpe -H \'$HOSTADDRESS$\' -c check_disk -a \'$ARG1$\''
    }

  nagios_command { 'check_load':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${commands_dir}/check_load.cfg",
    command_line                       => '$USER1$/check_nrpe -H \'$HOSTADDRESS$\' -c check_load -a \'$ARG1$\' \'$ARG2$\''
    }

  nagios_command { 'check_memory':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${commands_dir}/check_memory.cfg",
    command_line                       => '$USER1$/check_nrpe -H \'$HOSTADDRESS$\' -c check_linux_memory'
    }

  nagios_command { 'check_swap':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${commands_dir}/check_swap.cfg",
    command_line                       => '$USER1$/check_nrpe -H \'$HOSTADDRESS$\' -c check_swap -a \'$ARG1$\' \'$ARG2$\''
    }

  nagios_command { 'check_net_stat':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${commands_dir}/check_net.cfg",
    command_line                       => '$USER1$/check_nrpe -H \'$HOSTADDRESS$\' -c check_net_stat -a \'$ARG1$\''
    }

  nagios_command { 'check_total_procs':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${commands_dir}/check_procs.cfg",
    command_line                       => '$USER1$/check_nrpe -H \'$HOSTADDRESS$\' -c check_total_procs -a \'$ARG1$\' \'$ARG2$\''
    }

  nagios_command { 'check_zombie_procs':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${commands_dir}/check_procs.cfg",
    command_line                       => '$USER1$/check_nrpe -H \'$HOSTADDRESS$\' -c check_zombie_procs -a \'$ARG1$\' \'$ARG2$\''
    }

  nagios_command { 'check_uptime':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${commands_dir}/check_uptime.cfg",
    command_line                       => '$USER1$/check_nrpe -H \'$HOSTADDRESS$\' -c check_linux_uptime'
    }

  nagios_command { 'check_users':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${commands_dir}/check_users.cfg",
    command_line                       => '$USER1$/check_nrpe -H \'$HOSTADDRESS$\' -c check_users -a \'$ARG1$\''
    }

  nagios_command { 'check_ssh':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${commands_dir}/check_ssh.cfg",
    command_line                       => '$USER1$/check_ssh \'$ARG1$\' \'$HOSTADDRESS$\''
    }

  nagios_command { 'process-host-perfdata':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${commands_dir}/process_host_perfdata.cfg",
    command_line                       => "/usr/bin/perl ${perfdata_perl}/process_perfdata.pl"
    }

  nagios_command { 'process-service-perfdata':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${commands_dir}/process_service_perfdata.cfg",
    command_line                       => "/usr/bin/perl ${perfdata_perl}/process_perfdata.pl -d HOSTPERFDATA"
    }

  nagios_command { 'process-host-perfdata-file':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${commands_dir}/process_host_perfdata_file.cfg",
    command_line                       => "/usr/bin/mv ${home_dir}/host-perfdata ${perfdata_spool}/host-perfdata.\$TIMET\$"
    }

  nagios_command { 'process-service-perfdata-file':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${commands_dir}/process_service_perfdata_file.cfg",
    command_line                       => "/usr/bin/mv ${home_dir}/service-perfdata ${perfdata_spool}/service-perfdata.\$TIMET\$"
    }

  }


# vim: set ts=2 sw=2 et :
