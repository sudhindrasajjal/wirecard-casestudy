node <NODENAME> {

  include tomcat_custom

  package{'oracle-java8-jdk':
    ensure => present,
  }

  exec {'/bin/systemctl daemon-reload':}

}