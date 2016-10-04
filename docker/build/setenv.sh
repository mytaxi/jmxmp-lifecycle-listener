echo "env variables as seen by the tomcat process:"
env

# Where your tomcat installation lives
export CATALINA_BASE="/usr/tomcat"
export CATALINA_HOME="/usr/tomcat"
export JASPER_HOME="/usr/tomcat"
export CATALINA_TMPDIR="/usr/tomcat/temp"

# You can pass some parameters to java here if you wish to
export JAVA_OPTS="-Dfile.encoding=utf-8 -server -XX:+UseConcMarkSweepGC -Djava.awt.headless=true -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.ssl=false -XX:PermSize=64m -XX:MaxPermSize=128m -Xms256m -Xmx512m -Xss512k -verbose:GC -XX:+CMSClassUnloadingEnabled -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/var/log/tomcat7"

# What user should run tomcat
export TOMCAT_USER="tomcat"

# You can change your tomcat locale here
#export LANG="en_US"

# Run tomcat under the Java Security Manager
export SECURITY_MANAGER="false"

# Time to wait in seconds, before killing process
export SHUTDOWN_WAIT="30"

# Whether to annoy the user with "attempting to shut down" messages or not
export SHUTDOWN_VERBOSE="false"

# Set the TOMCAT_PID location
export CATALINA_PID="/var/run/tomcat.pid"

$(/usr/bin/env > /tmp/env)
