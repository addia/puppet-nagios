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
    cryptpasswd                        => '$apr1$6JKsZ.Ft$bVDJbTOCqakLOfh5azDAq.',
	target                             => '/etc/nagios/passwd',
    }

  htpasswd { 'nagiosviewer':
    cryptpasswd                        => '$apr1$MUBH5EW.$m7JlU81PTUMrjsrCDiS7J1',
	target                             => '/etc/nagios/passwd',
    }

  }


# via: set ts=2 sw=2 et :
