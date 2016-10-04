#
#
# Description of the Class:
#
#   This class is meant to be called from init.pp only.
#
#
# ===========================
#
class nagios::config::user (
  $package_name                        = $nagios::params::package_name,
  ) inherits nagios::params {

  notify { "## --->>> Updating the user config files for: ${package_name}": }


  # add the users to the /etc/nagios/passwd file
  htpasswd { 'nagiosadmin':
    cryptpasswd                        => '$apr1$skoK/jJV$fgublQ4T974WSEjsnEWVc/',
	target                             => '/etc/nagios/passwd',
    }

  htpasswd { 'nagiosview':
    cryptpasswd                        => '$apr1$C4DbIUV1$j0acdXvtiQjOyKvHYI1gl.',
	target                             => '/etc/nagios/passwd',
    }

  }


# via: set ts=2 sw=2 et :
