node <NODENAME> {

  include tomcat_custom
  include tomcat_custom::multi_instance

  package{'oracle-java8-jdk':
    ensure => present,
  }

  exec {'/bin/systemctl daemon-reload':}

}