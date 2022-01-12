node /^appserver/ {
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
}

node /^dbserver/ {
  include mysql
}

node /^web/ {
  package { 'nginx':
    ensure => present,
  }

  service { 'nginx':
    ensure => running,
    require => Package['nginx'],
 }
}

node /^tst[0-2]/ {
  exec { 'update':
    path => ['/usr/bin', '/usr/sbin', '/bin'],
    command => "apt-get update",
  }
}

node default {
}