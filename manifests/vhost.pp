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

class phpmyadmin::vhost (
  vhost_enabled = 'true',
  priority      = '20',
  docroot       = $phpmyadmin::params::doc_path,
  aliases       = '',
  vhost_name    = "phpdb.${::domain}",
  ssl           = 'false',
  ssl_cert      = '',
  ssl_key       = '',
)
inherits phpmyadmin::params
{
  
  #Creates a basic vhost entry for apache
    apache::vhost { "${vhost_name}":
      docroot       => "${docroot}",
      priority      => "${priority}",
      serveraliases => "${aliases}",
      ensure        => $vhost_enabled ? {
        'true'  => 'present',
        default => 'absent',
      },
      ssl           => $ssl,
      port          => $ssl ? { #Might need to add ability to define port. Consider...
        'true'  => '443',
        default => '80',
      },
      template      => $ssl ? {
        'true'  => "${settings::confdir}/modules/phpmyadmin/templates/apache/vhost_ssl_template.erb",
        default => "${settings::confdir}/modules/phpmyadmin/templates/apache/vhost_template.erb",
      },
    }

    #Generate ssl key/cert with provided file-locations
    if $ssl == 'true' {
      file { "${apache_config_dir}/phpmyadmin.crt":
        ensure => $vhost_enabled ? {
          'true'  => 'present',
          default => 'absent',
        },
        mode   => '0644',
        source => $ssl_cert,
      }
      file { "${apache_config_dir}/phpmyadmin.key":
        ensure => $vhost_enabled ? {
          'true'  => 'present',
          default => 'absent',
        },
        mode   => '0644',
        source => $ssl_key,
      }
    }
                   
} 
 
