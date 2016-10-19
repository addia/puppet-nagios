# == Class nagios::housekeep
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
class nagios::housekeep (
  $package_name                        = $nagios::params::package_name,
  $objects_dir                         = $nagios::params::objects_dir,

  ) inherits nagios::params {

  notify { "## --->>> Removing unwanted config files for: ${package_name}": }

  # remove unwanted files ...
  file {
         [
           "${objects_dir}/printer.cfg",
           "${objects_dir}/switch.cfg",
           "${objects_dir}/windows.cfg",
           "${objects_dir}/localhost.cfg",
           "${objects_dir}/templates.cfg",
           "${objects_dir}/commands.cfg.sample",
           "${objects_dir}/contacts.cfg.sample",
           "${objects_dir}/localhost.cfg.sample",
           "${objects_dir}/printer.cfg.sample",
           "${objects_dir}/switch.cfg.sample",
           "${objects_dir}/templates.cfg.sample",
           "${objects_dir}/timeperiods.cfg.sample",
           "${objects_dir}/windows.cfg.sample"
         ]:
    ensure                             => 'absent',
    }
    
  }


# vim: set ts=2 sw=2 et :
