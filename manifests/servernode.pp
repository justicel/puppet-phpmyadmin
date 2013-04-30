# == Class: phpmyadmin::servernode
#
# Defines a server usable to phpmyadmin. Can either use exported resources or as a defined resource
#
# === Parameters
# [*myserver_name*]
#   What to name the server and use for accessing it in phpmyadmin. This can be set to an ip address, hostname or fqdn.
#   It default to the defined resource name
# [*server_group*]
#   If used as a defined resource, this will be used to select which servers to install for a specific phpmyadmin instance.
#
# === Examples
#
#  phpmyadmin::servernode { "${::fqdn}":
#    myserver_name => $::fqdn,
#    server_group  => 'default',
#  }
#
#  @@phpmyadmin::servernode { "${::fqdn}":
#    server_group => 'default',
#  }
#
# === Authors
#
# Justice London <jlondon@syrussystems.com>
#
# === Copyright
#
# Copyright 2013 Justice London, unless otherwise noted.
#

define phpmyadmin::servernode (
  $myserver_name = $name,
  $server_group,
)
{
  include phpmyadmin::params

  #Generate a server entry for the realized server ON the phpmyadmin server
  concat::fragment { "${server_group}_phpmyadmin_server_${name}":
    order   => "20-${server_group}-${myserver_name}",
    target  => "${phpmyadmin::params::config_file}",
    content => template('phpmyadmin/servernode.erb'),
  }

}
