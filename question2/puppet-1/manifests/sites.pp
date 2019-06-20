class { 'java':
  package => 'java-1.8.0-openjdk-devel',
}

tomcat::install { '/opt/tomcat-instances':
  source_url => 'http://mirrors.estointernet.in/apache/tomcat/tomcat-9/v9.0.21/bin/apache-tomcat-9.0.21.tar.gz'
}

tomcat::instance { 'tomcatA':
  catalina_home => '/opt/tomcat-instances',
  catalina_base => '/opt/tomcat-instances/tomcatA',
  user => 'tomcat9',
  group => 'tomcat9',
}

tomcat::instance { 'tomcatB':
  catalina_home => '/opt/tomcat-instances',
  catalina_base => '/opt/tomcat-instances/tomcatB',
}

tomcat::config::server { 'tomcatA':
  catalina_base => '/opt/tomcat-instances/tomcatA',
  port          => '8080',
}

tomcat::config::server { 'tomcatB':
  catalina_base => '/opt/tomcat-instances/tomcatB',
  port          => '18080',
}

#tomcat::war { 'hello_world.war':
#  catalina_base => '/opt/tomcat-instances/tomcatA',
#  war_source    => <WAR filepath>,
#}

#tomcat::war { 'hello_world.war':
#  catalina_base => '/opt/tomcat-instances/tomcatA',
#  war_source    => <WAR filepath>,
#}

