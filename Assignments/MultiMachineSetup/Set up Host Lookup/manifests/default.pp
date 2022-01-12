node default {
  exec { 'apt-get update':
    command => 'sudo apt-get update',
    path    => ['/bin', '/usr/bin'],
  }

  file {'/vagrant/hosts':
    ensure => file,
  }
  
  file {'/home/hosts':
    ensure => link,
    force => true,
    target => '/vagrant/hosts'
  }

  host{$hostname:
    ensure=>'present',
    target=>'/vagrant/hosts',
    ip=>$networking[interfaces][eth1][ip],
  }
}