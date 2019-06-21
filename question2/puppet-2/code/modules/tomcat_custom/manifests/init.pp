# == Class: tomcat
#
# Class to manage installation and configuration of Tomcat.
#
# === Parameters
#
# [*catalina_home*]
#   The base directory for the Tomcat installation.
#
# [*user*]
#   The user to run Tomcat as.
#
# [*group*]
#   The group to run Tomcat as.
#
# [*manage_user*]
#   Boolean specifying whether or not to manage the user. Defaults to true.
#
# [*purge_connectors*]
#   Boolean specifying whether to purge all Connector elements from server.xml. Defaults to false.
#
# [*purge_realms*]
#   Boolean specifying whether to purge all Realm elements from server.xml. Defaults to false.
#
# [*manage_group*]
#   Boolean specifying whether or not to manage the group. Defaults to true.
#
class tomcat_custom (
  $catalina_home       = '/opt/tomcat-instances',
  $package_name        = undef,
  $tomcat_version      = "present",
  $install_from_source = false,
  $purge_connectors    = false,
  $purge_realms        = false,
  $manage_user         = true,
  $manage_group        = true,
) {
  package { $package_name:
    ensure  => $tomcat_version,
    require => Package['authbind', 'libecj-java'],
  }

  package { 'authbind':
    ensure          => present,
    install_options => [ '--allow-unauthenticated','--force-yes'],
  }

  package { 'libecj-java':
    ensure          => present,
    install_options => [ '--allow-unauthenticated','--force-yes'],
  }

  case $package_name{
    'tomcat7':{
      $user  = 'tomcat7'
      $group = 'tomcat7'
    }
    'tomcat8': {
      $user  = 'tomcat8'
      $group = 'tomcat8'
    }
    'tomcat9': {
      $user  = 'tomcat9'
      $group = 'tomcat9'
    }
    default:{
      notify{'Please specify correct package name for tomcat e.g. tomcat7':}
    }
  }

  file { $catalina_home:
    ensure => directory,
    owner  => $user,
    group  => $group,
  }
}
