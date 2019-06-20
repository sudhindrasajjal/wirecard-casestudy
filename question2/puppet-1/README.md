This is a simple puppet module to provision multiple tomcat instances to a node.


### Pre-Requisites
Install the puppet-tomcat module on the master

```
puppet module install puppetlabs-tomcat --version 3.0.0
```


Then in the puppet master, add the **manifests/sites.pp** to your manifests directory (Usually located at /etc/puppet/manifests).

You can apply the changes on the agent by running (Considering the master has signed the agent's cert previously)
```
puppet agent -tv
```

This should install 2 tomcats (TomcatA & TomcatB) on ports 8080 & 18080 respectively.


To deploy a war, one can specify the location of the war artifact in the sites.pp file in the `tomcat::war` code block
