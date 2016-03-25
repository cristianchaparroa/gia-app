## GIA Development

This a configuration to build a docker image, this contains:

  - WildFly 9.0.2
  - Myfaces 2.2.9
  - gia app setup

### Setup GIA environment

By confidentiality you must to get the sign to sing files the pdf files,and certicamara modules.
 


 ### Build the images

 To build the image  you need to run the following

 `$ docker build --tag=gia-app-name .`


 ### Run the container

 To run the container is necessary  has access to the ports `8080` and `9990`, port by default to run http service and web console.

 `$ docker run -it -p 8080:8080 -p 9990:9990 gia-app-name`


 ### Access via web

 To see the applications deployed or access to web console is necessary get the ip server, then must be run the following command to get the ip to the machine in which is running the container

 `$ docker-machine ls`

 The command above show us something like this:

 `NAME ACTIVE DRIVER STATE URL SWARM`

`default virtualbox Running tcp://192.168.99.100:2376`
