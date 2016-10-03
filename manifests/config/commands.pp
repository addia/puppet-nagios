# == Class nagios::config::commands
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
class nagios::config::commands (
  $package_name                        = $nagios::params::package_name,
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
    command_line                       => '$USER1$/check_ping -H \'$HOSTADDRESS$\' -w $ARG1$ -c $ARG2$ -p 5'
    }

  nagios_command { 'check_cpu':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${commands_dir}/check_cpu.cfg",
    command_line                       => '$USER1$/check_nrpe -H \'$HOSTADDRESS$\' -c check_linux_cpu'
    }

  }


# vim: set ts=2 sw=2 et :
