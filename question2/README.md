### Tomcat Puppet Module

For this problem I have presented two solutions, the first folder **puppet-1** contains a simple solution to install multiple instances of tomcat on a node using the tomcat puppet module. It just contains a `manifests/sites.pp` file which needs to be present on the puppet master. A simple puppet run on the agent should do the trick.


In **puppet-2**, I have added a new class in `code/modules/tomcat_custom/manifests` to handle multi-instance provisioning, it is completely parametrized and customizable. All the variables are declared via the hiera file. The reference and details about the parameters can be found [here](https://github.com/puppetlabs/puppetlabs-tomcat). 
