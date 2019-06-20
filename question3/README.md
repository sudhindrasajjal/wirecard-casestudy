I have pushed a docker image which contains the Jenkins server

### Setup
Fetch the docker image from Docker Hub
```
docker pull sudhindrasajjal/jenkins-demo:1.0
```


Run the docker by executing
```
docker run -itd -p 8080:8080 -p 8081:8081 -p 50000:50000 --name jenkins_demo -v jenkins_home:/var/jenkins_home sudhindrasajjal/jenkins-demo:1.0
```

Start Tomcat in the container by executing
```
docker exec -it --user root jenkins_demo /bin/bash
root@<containerID>:/# /opt/tomcat/apache-tomcat-9.0.21/bin/startup.sh
```


Open your web browser and go to  `0.0.0.0:8080`
Enter the Jenkins credentials provided in the email

You can trigger a build for  `demo-build-pipeline`

Once the pipeline finishes executing, you can verify if the war was deployed by going to `0.0.0.0:8081/helloworld` in your browser.
