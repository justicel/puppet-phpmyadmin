puppet-phpmyadmin
=================

This is the puppet phpMyAdmin module which allows you to install and manage phpMyAdmin.
Additionally you can use resources to specify a group of servers to add to a phpMyAdmin server.

The reason to use this to manage your phpMyAdmin rather than simply installing a package is that
this module allow you to use stored resources to automatically generate a list of servers to use.

With this you don't need to worry about manually adding server entries to phpmyadmin or similar.
Instead you can add a server similar to below:

Usage
-----
	node 'phpmyadminserver' {
	  class { 'phpmyadmin': }
	  phpmyadmin::server{ 'default': }
	}

	node 'mysqlserver' {
	  phpmyadmin::servernode { "${::ipaddress}":
	      server_group => 'default',
	  }
	}

License
-------

You are free to fork, modify, burn, break, twist or twine this module.
If you do re-use the code, please give me credit for it though.

Contact
-------

Justice London<jlondon@syrussystems.com>

Support
-------

Please log tickets and issues at our [Projects site](http://github.com/justicel/puppet-phpmyadmin)
