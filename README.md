# Maven project for a JMXMP connector server
--------------------------------------------

## About
When running JVMs in Docker, it is sometimes necessary to get a remote connection into the JVM via `jconsole` or `jvisualvm`. With standard JMX-RMI this is only possible, when the Docker Bridge portmappings are the same inside and outside of the container (X:X). It is not possible to assign use random port mappings for that. 

We were looking for a workaround to achieve random portmappings and still be able to utilize JMX-RMI connections. With JMXMP with have found just that.

## Usage

The Docker folder contains a sample `Dockerfile` with all the necessary settings. The `docker-compose.yml` contains instructions for building and running the container. It will map the JMX-RMI port 5555 to the outside on port 5000 to demonstrate the successful X:Y port mapping.

Make sure the JMX client also adds the jmxremote_optional.jar to the classpath.
For JVisualVM: jvisualvm --cp:a jmxremote_optional.jar


Project inspired by: http://stackoverflow.com/questions/11413178/how-to-enable-jmxmp-in-tomcat
JMXMP Jars: http://stackoverflow.com/questions/11412560/where-to-download-jmxmp