# == Class nagios::contacts
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
class nagios::contacts {

  notify { "## --->>> Adding manitoring contacts for: ${package_name}": }

  # manage the nagios monitoring contacts:
  nagios_contact { 'nagiosadmin':
    ensure                             => 'present',
    target                             => "${base_dir}/contacts.cfg",
    mode                               => '644',
    contact_name                       => 'nagiosadmin',
	  alias                              => 'WebOps Team',
    email                              => 'addi.abel@digital.landregistry.gov.uk',
    use                                => 'generic-contact'
    }

  nagios_contact { 'nagiosview':
    ensure                             => 'present',
    target                             => "${base_dir}/contacts.cfg",
    mode                               => '644',
    contact_name                       => 'nagiosview',
	  alias                              => 'Nagios Viewer',
    email                              => 'nagios@localhost',
    use                                => 'readonly-contact'
    }

  # add the nagios contactgroup:
  nagios_contactgroup { 'admins':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${base_dir}/contacts.cfg",
    contactgroup_name                  => 'admins',
    alias                              => 'Nagios Administrators',
    members                            => 'nagiosadmin,nagiosview'
    }

  # add the contact template:
  nagios_contact { 'generic-contact':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${base_dir}/contacts.cfg",
    contact_name                       => 'generic-contact',
    host_notifications_enabled         => '1',
    service_notifications_enabled      => '1',
    can_submit_commands                => '1',
    service_notification_period        => '24x7',
    host_notification_period           => '24x7',
    service_notification_options       => 'w,u,c,r,f,s',
    host_notification_options          => 'd,u,r,f,s',
    service_notification_commands      => 'notify-service-by-email',
    host_notification_commands         => 'notify-host-by-email',
    register                           => '0'
    }

  nagios_contact { 'readonly-contact':
    ensure                             => 'present',
    mode                               => '644',
    target                             => "${base_dir}/contacts.cfg",
    contact_name                       => 'readonly-contact',
    host_notifications_enabled         => '1',
    service_notifications_enabled      => '1',
    can_submit_commands                => '0',
    service_notification_period        => 'workhours',
    host_notification_period           => 'workhours',
    service_notification_options       => 'w,u,c,r,f,s',
    host_notification_options          => 'd,u,r,f,s',
    service_notification_commands      => 'notify-service-by-email',
    host_notification_commands         => 'notify-host-by-email',
    register                           => '0'
    }

  }


# vim: set ts=2 sw=2 et :
