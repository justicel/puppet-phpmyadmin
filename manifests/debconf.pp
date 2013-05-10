class debconf
{
  package{'debconf': ensure => installed}
}

define debconf::set_selection ( $selection = '', $value_type = 'string', $value = '' )
{
  include debconf
  exec{ $name:
    command => "/bin/echo debconf ${selection} ${value_type} ${value} | /usr/bin/debconf-set-selections",
    require => Package['debconf'],
    unless  => "/usr/bin/debconf-get-selections | /bin/egrep 'debconf[[:space:]]+${selection}+[[:space:]]+${value_type}+[[:space:]]+${value}'",
  }
}
