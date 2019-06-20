# Puppet module for multi instance tomcat
class tomcat_custom::multi_instance{
  $data = hiera_hash("tomcat_config")
  
  $instances = keys($data)

  instance_setup{ $instances: }

}

# defined resource for individual instance setup
define instance_setup() {

  $tomcat_user = $tomcat_custom::user
  $tomcat_group = $tomcat_custom::group
  $tomcat_package_name = "$tomcat_custom::package_name"
  $instant = $tomcat_custom::multi_instance::data["$name"]
  $instance_name = "${instant['name']}"
  $catalina_base = "$tomcat_custom::catalina_home/$instance_name"
  $conf_dir = "${catalina_base}/conf"
  $log_dir = "${catalina_base}/logs"
  $app_dir = "${catalina_base}/webapps"
  $bin_dir = "${catalina_base}/bin"
  $base_webapp_dir = "/usr/share/${tomcat_package_name}-admin"
  $tomcat_dirs = [ $catalina_base, $conf_dir , $log_dir, $app_dir, $bin_dir ]
  $service_ensure = pick($instant['service_ensure'], 'true')

  file { $tomcat_dirs:
    ensure => directory,
    owner  => $tomcat_user,
    group  => $tomcat_group,
    mode   => '0665',
  }
  file { "${catalina_base}/conf/server.xml":
    ensure  => file,
    owner   => $tomcat_user,
    group   => $tomcat_group,
    mode    => '0665',
    require => [ File[$catalina_base], File[$conf_dir] ] ,
    content => template("tomcat_custom/${instant['server_conf']}" ) ,
  }
  file { "${catalina_base}/conf/tomcat-env.sh":
    ensure  => file,
    owner   => $tomcat_user,
    group   => $tomcat_group,
    mode    => '0765',
    require => [ File[$catalina_base],  File[$conf_dir] ],
    content => template("tomcat_custom/${instant['tomcat_env']}"),
  }
  file { "${catalina_base}/conf/tomcat-users.xml":
    ensure  => file,
    owner   => $tomcat_user,
    group   => $tomcat_group,
    mode    => '0665',
    require => [  File[$catalina_base], File[$conf_dir] ],
    content => template("tomcat_custom/tomcat_users.erb"),
  }
  file { "${catalina_base}/conf/web.xml":
    ensure  => file,
    owner   => $tomcat_user,
    group   => $tomcat_group,
    mode    => '0665',
    require => [ File[$catalina_base], File[$conf_dir]],
    source  => "puppet:///modules/tomcat_custom/web.xml",
  }
  file { "${catalina_base}/conf/logging.properties":
    ensure  => file,
    owner   => $tomcat_user,
    group   => $tomcat_group,
    mode    => '0665',
    require => [ File[$catalina_base], File[$conf_dir]],
    source  => "puppet:///modules/tomcat_custom/logging.properties",
  }
  service {"tomcat_${instance_name}":
    require => File["/etc/init.d/tomcat_${instance_name}"],
    ensure  => $service_ensure,
    enable  => $service_ensure,
  }
  if ( $instant['manager'] == "true" ){
    file { "${app_dir}/manager":
      ensure => link,
      force  => true,
      target => "${base_webapp_dir}/manager",
    }
    file { "${app_dir}/ROOT":
      ensure  => link,
      force   => true,
      target  => "${base_webapp_dir}/ROOT",
      require => [ File[$catalina_base], File[$app_dir]],
    }
  }
  if ($instant["systemd"] == true) {
    file { "${bin_dir}/startup.sh":
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      content => template("tomcat_custom/tomcat_systemd_startup.erb"),
    }
    file { "${bin_dir}/shutdown.sh":
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      content => template("tomcat_custom/tomcat_systemd_shutdown.erb"),
    }
    file { "/lib/systemd/system/tomcat_${instance_name}.service":
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template("tomcat_custom/tomcat_service.erb"),
      notify  => Exec["Systemd daemon reload ${instance_name}"],
    }
    file { "${bin_dir}/setenv.sh":
      ensure  => file,
      owner   => $tomcat_user,
      group   => $tomcat_group,
      mode    => '0765',
      require => [ File[$catalina_base],  File[$bin_dir] ],
      content => template("tomcat_custom/${instant['tomcat_env']}"),
    }
    exec { "Systemd daemon reload ${instance_name}":
      command => '/bin/systemctl  daemon-reload',
      refreshonly => true,
    }

    file { "/etc/init.d/tomcat_${instance_name}":
      ensure  => file,
      owner   => root,
      group   => root,
      mode    => '0755',
      content => template("tomcat_custom/tomcat_systemd_init_wrapper.erb" ),
    }
  } else {
    file { "/etc/init.d/tomcat_${instance_name}":
      ensure  => file,
      owner   => root,
      group   => root,
      mode    => '0755',
      content => template("tomcat_custom/${instant['init_script']}" ),
    }
  }
}
