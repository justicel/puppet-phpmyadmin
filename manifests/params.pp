#Phpmyadmin installation parameters
#Sets variables for both centos/redhat and ubuntu OS versions currently

class phpmyadmin::params
{

  case $::operatingsystem {
    'RedHat', 'CentOS': {
      $package_name          = 'phpMyAdmin'
      $apache_config_dir     = '/etc/httpd/conf'
      $site_enable_dir       = '/etc/httpd/conf.d/'
      $apache_default_config = '/etc/httpd/conf.d/phpMyAdmin.conf'
      $config_file           = '/etc/phpMyAdmin/config.inc.php'
      $doc_path              = '/usr/share/phpMyAdmin'
      $data_dir              = '/var/lib/phpMyAdmin'
      $apache_name           = 'httpd'
      $preseed_package       = false
    }
    /^(Debian|Ubuntu)$/: {
      $package_name          = 'phpmyadmin'
      $apache_config_dir     = '/etc/apache2'
      $site_enable_dir       = "${apache_config_dir}/sites-enabled"
      $apache_default_config = '/etc/apache2/conf.d/phpmyadmin.conf'
      $config_file           = '/etc/phpmyadmin/config.inc.php'
      $doc_path              = '/usr/share/phpmyadmin'
      $data_dir              = '/var/lib/phpmyadmin'
      $apache_name           = 'apache2'
      $preseed_package       = true
    }
    default: { }
  }

}
