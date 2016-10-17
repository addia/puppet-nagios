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
class nagios::config {

  notify { "## --->>> This is the complete config for: ${package_name}": }

  class create_standard_file {

    File {
      ensure                           => 'present',
      owner                            => 'root',
      group                            => 'root',
      mode                             => '0644',
      replace                          => true,
      }

    # put the commands for notification and graphing in place
    file { "${base_dir}/commands.cfg":
      source                           => "puppet:///modules/nagios/commands.cfg"
      }

    # put to the timeperiods for alerting in place
    file { "${base_dir}/timeperiods.cfg":
      source                           => "puppet:///modules/nagios/timeperiods.cfg"
      }
    }


  exec { 'manage_config_files' :
    command                            => "cd ${config_dir}; mv cgi.cfg.sample cgi.cfg; mv nagios.cfg.sample nagios.cfg",
    creates                            => "${config_dir}/nagios.cfg",
    path                               => "/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin",
    }

  exec { 'backup_config_files' :
    command                            => "cd ${config_dir}; cp -p cgi.cfg cgi.cfg.bak; cp -p nagios.cfg nagios.cfg.bak",
    creates                            => "${config_dir}/nagios.cfg.bak",
    path                               => "/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin",
    }

  exec { 'manage_private_config' :
    command                            => "cd ${config_dir}; mv resource.cfg.sample ${private_dir}/resource.cfg",
    creates                            => "${private_dir}/resource.cfg",
    path                               => "/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin",
    }

  }


# via: set ts=2 sw=2 et :
