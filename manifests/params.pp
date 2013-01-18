#Phpmyadmin installation parameters
#Sets variables for both centos/redhat and ubuntu OS versions currently

class phpmyadmin::params 
{
  
  case $operatingsystem {
    'RedHat', 'CentOS': {
      $package_name          = 'phpMyAdmin' 
      $apache_default_config = '/etc/httpd/conf.d/phpMyAdmin.conf'
      $config_file           = '/etc/phpMyAdmin/config.inc.php'
      $doc_path              = '/usr/share/phpMyAdmin'
    }
    /^(Debian|Ubuntu)$/: {
      $package_name = 'phpmyadmin'
    }
  }

}
