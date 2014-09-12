#Simple class to validate and seed the correct package selection for debian based systems
define phpmyadmin::debconf::set_selection ( $selection = '', $value_type = 'string', $value = '' ) {
  #Install debconf package as needed
  ensure_packages(['debconf-utils'])

  #Run the actual debconf selector
  exec { $name:
    command => "/bin/echo debconf ${selection} ${value_type} ${value} | /usr/bin/debconf-set-selections",
    require => Package['debconf-utils'],
    unless  => "/usr/bin/debconf-get-selections | /bin/egrep 'debconf[[:space:]]+${selection}+[[:space:]]+${value_type}+[[:space:]]+${value}'",
  }
}
