To use this puppet module
* Copy the `tomcat_custom` module to the modules directory on the puppetmaster
* Create a new environment or use the current `tomcat` environment available in `environments`
* Add your node name in `environments/tomcat/manifests/nodes.pp`
* You can additionally change the params in `environments/tomcat/hieradata/common_tomcat.yaml` or add your own node specific hiera

Run `puppet agent -tv` on the node to finish the installation of 2 tomcats (tomcatA and tomcatB) as mentioned in the hiera YAML
