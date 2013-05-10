# == Class: phpmyadmin::vhost
#
# Allows you to generate a vhost configuration for using phpmyadmin within a specific apache virtualhost.
# By default the phpmyadmin install will be available within the localhost definitions on apache.
# The class requires the use of puppetlabs-apache module
#
# === Parameters
# [*vhost_enabled*]
#   Default to true. Will allow you to install or uninstall the vhost entry
# [*priority*]
#   Defaults to 20, which is a reasonable default. This sets in which order the vhost is loaded.
# [*docroot*]
#   The default should be fine. This sets where the 'DocumentRoot' for the vhost is. This
#   defaults to the phpmyadmin shared resources path, which is then governed by config include.
# [*aliases*]
#   Allows you to set an alias for the phpmyadmin vhost, or to have an array of alias entries
# [*vhost_name*]
#   You can set a name for the vhost entry. This defaults to phpdb.$::domain
# [*ssl*]
#   Enable SSL support for the vhost. If enabled we disable phpmyadmin on port 80.
#
# [*ssl_cert*]
#   Define a file on the puppet server to be ssl cert.
# [*ssl_key*]
#   Define a file on the puppet server to be ssl key.
# === Examples
#
#  class { 'phpmyadmin::vhost'
#    vhost_name => 'phpmyadmin.domain.com',
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
define phpmyadmin::vhost(
  $vhost_enabled = true,
  $priority      = '20',
  $docroot       = $phpmyadmin::params::doc_path,
  $aliases       = '',
  $vhost_name    = $name,
  $ssl           = false,
  $ssl_cert      = '',
  $ssl_key       = '',
) {
  include apache

  case $ssl {
      true: {
        $port = '443'
      }
      default: {
        $port = '80'
      }
  }

  $conf_dir = $phpmyadmin::params::apache_config_dir
  $conf_dir_enable = $phpmyadmin::params::site_enable_dir

  #Generate ssl key/cert with provided file-locations
  if $ssl == true {
    file { "${conf_dir}/phpmyadmin_${vhost_name}.crt":
      ensure => $ensure,
      mode   => '0644',
      source => $ssl_cert,
    }
    file { "${conf_dir}/phpmyadmin_${vhost_name}.key":
      ensure => $ensure,
      mode   => '0644',
      source => $ssl_key,
    }
  }

  #Creates a basic vhost entry for apache
  apache::vhost { $vhost_name:
    ensure          => $ensure,
    docroot         => $docroot,
    priority        => $priority,
    port            => $port,
    serveraliases   => $aliases,
    ssl             => $ssl,
    ssl_cert        => $ssl ? {
      true    => "${conf_dir}/phpmyadmin_${vhost_name}.crt",
      default => undef,
    },
    ssl_key         => $ssl ? {
      true    => "${conf_dir}/phpmyadmin_${vhost_name}.key",
      default => undef,
    },
    custom_fragment => template('phpmyadmin/apache/phpmyadmin_fragment.erb'),
  }

}
