# Class: tomcat::params
#
# This class manages Tomcat parameters.
#
# Parameters:
# - $catalina_home is the root of the Tomcat installation.
# - The $user Tomcat runs as.
# - The $group Tomcat runs as.
class tomcat_custom::params {
  $catalina_home = '/opt/tomcat-instances'
  $user          = 'tomcat'
  $group         = 'nobody'
}
