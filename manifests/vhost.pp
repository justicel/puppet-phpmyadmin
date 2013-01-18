# == Class: phpmyadmin::vhost
#
# Allows you to generate a vhost configuration for using phpmyadmin within a specific apache virtualhost.
# By default the phpmyadmin install will be available within the localhost definitions on apache.
#
# === Parameters
# [*enabled*]
#   Default to true. This sets the package as installed or uninstalled and affects the config as well.
# [*ip_access_ranges*]
#   True to what it sounds like, this sets the ip ranges which are allowed to access phpmyadmin.
#   These IP ranges can be either a single range or an array.
#
# === Examples
#
#  class { phpmyadmin:
#    enabled          => 'true',
#    ip_access_ranges => [ '192.168.1.0', '10.30.1.1' ],
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

