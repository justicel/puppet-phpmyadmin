# == Class: phpmyadmin
#
# This is the installer/main class for phpmyadmin. This allows you to do a very basic install of phpmyadmin.
# Additionally the class will generate a basic apache config file with some basic permissions for access
#
# === Parameters
# [*enabled*]
#   Default to true. This sets the package as installed or uninstalled and affects the config as well.
# [*ip_access_ranges*]
#   True to what it sounds like, this sets the ip ranges which are allowed to access phpmyadmin.
#   These IP ranges can be either a single range or an array. Should be in dotted quad or ipv6
#   notation (ex: 192.168.1.0/24, 192.168.1.10, 2012:db8:1234:ffff:ffff:ffff:ffff:ffff, etc.)
#
# === Examples
#
#  class { phpmyadmin:
#    enabled          => 'true',
#    ip_access_ranges => [ '192.168.1.0/24', '10.30.1.1' ],
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
class phpmyadmin (
  $enabled          = 'true',
  $ip_access_ranges = ["${::network_eth0}/${::netmask_eth0}"],
)
inherits phpmyadmin::params
{
  if $phpmyadmin::params::preseed_package {
    debconf::set_selection{ 'reconfigure-webserver':
      selection   => 'phpmyadmin/reconfigure-webserver',
      value_type  => 'multiselect',
      value       => 'apache2',
      before      => Package[$phpmyadmin::params::package_name],
    }
  }

  #Install or remove package based on enable status
  package { $phpmyadmin::params::package_name:
    ensure => $enabled ? {
      'true'  => 'present',
      default => 'absent',
    },
  }

  #Default/basic apache config file for phpMyAdmin
  file { $phpmyadmin::params::apache_default_config:
    ensure  => $enabled ? {
      'true'  => 'present',
      default => 'absent',
    },
    content => template('phpmyadmin/phpMyAdmin.conf.erb'),
    require => Package[$phpmyadmin::params::package_name],
    notify  => Service[$phpmyadmin::params::apache_name],
  }

}

