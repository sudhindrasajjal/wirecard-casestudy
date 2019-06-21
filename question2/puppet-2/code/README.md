To use this puppet module

* Install the puppetlabs-tomcat module by running `puppet module install puppetlabs-tomcat --version 3.0.0` on your puppetmaster
* Copy the `tomcat_custom` module to the modules directory on the puppetmaster
* Create a new environment or use the current `tomcat` environment available in `environments`
* Add your node name in `environments/tomcat/manifests/nodes.pp`
* Make sure you have the right tomcat version installed, or you can also install from source using the tomcat-puppet module.
* You can additionally change the params in `environments/tomcat/hieradata/common_tomcat.yaml` or add your own node specific hiera

Run `puppet agent -tv` on the node to finish the installation of 2 tomcats (tomcatA and tomcatB) as mentioned in the hiera YAML

