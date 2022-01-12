exec { 'update':
  path => ['/usr/bin', '/usr/sbin', '/bin'],
  command => "apt-get update",
}

package { curl:
   ensure => "installed",
   require => Exec['update'],
}

exec {'before installing node.js':
  path => ['/usr/bin', '/usr/sbin', '/bin'],
  command => "curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -",
}

package { nodejs:
   ensure => "installed",
   require => [ 
	Exec['update'],
	Exec['before installing node.js']
   ],
}