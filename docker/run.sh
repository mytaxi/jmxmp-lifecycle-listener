#!/bin/sh

# add tomcat user and set permissions and run logrotate hourly
adduser -D tomcat
chown -R tomcat:tomcat /usr/tomcat
chown -R root:tomcat /usr/tomcat/temp
mkdir /var/log/tomcat7
chown -R tomcat /var/log/tomcat7


cat << EOF > /usr/tomcat/conf/tomcat-users.xml
<?xml version='1.0' encoding='utf-8'?>
<tomcat-users>
    <role rolename="manager"/>
    <role rolename="manager-gui"/>
    <role rolename="manager-script"/>
    <role rolename="manager-jmx"/>
    <role rolename="manager-status"/>
    <user name="admin" password="password" roles="admin,manager,admin-gui,admin-script,manager-gui,manager-script,manager-jmx,manager-status" /> -->
</tomcat-users>
EOF

cat << EOF > /usr/tomcat/conf/server.xml
<?xml version='1.0' encoding='utf-8'?>
<Server port="8005" shutdown="SHUTDOWN">
    <Listener className="org.apache.catalina.startup.VersionLoggerListener" />
    <Listener className="org.apache.catalina.core.AprLifecycleListener" SSLEngine="on" />
    <Listener className="org.apache.catalina.core.JasperListener" />
    <Listener className="org.apache.catalina.core.JreMemoryLeakPreventionListener" />
    <Listener className="org.apache.catalina.mbeans.GlobalResourcesLifecycleListener" />
    <Listener className="org.apache.catalina.core.ThreadLocalLeakPreventionListener" />
	  <Listener className="javax.management.remote.extension.JMXMPLifecycleListener" port="5555" />

    <GlobalNamingResources>

        <Resource name="UserDatabase" auth="Container"
            type="org.apache.catalina.UserDatabase"
            description="User database that can be updated and saved"
            factory="org.apache.catalina.users.MemoryUserDatabaseFactory"
            pathname="conf/tomcat-users.xml" />

    </GlobalNamingResources>

    <Service name="Catalina">
        <Connector port="8080" protocol="org.apache.coyote.http11.Http11NioProtocol"
            connectionTimeout="20000"
            redirectPort="8443"
            compression="on"
            asyncTimeout="10000"
            compressionMinSize="512"
            noCompressionUserAgents="gozilla, traviata"
            compressableMimeType="text/html,text/xml,application/json,application/x-protobuf"
            URIEncoding="UTF-8" />

        <Connector port="8009" protocol="AJP/1.3" redirectPort="8443" />

        <Engine name="Catalina" defaultHost="localhost">
            <Realm className="org.apache.catalina.realm.LockOutRealm">
                <Realm className="org.apache.catalina.realm.UserDatabaseRealm"
                    resourceName="UserDatabase"/>

            </Realm>

            <Host name="localhost"  appBase="webapps"
                unpackWARs="true" autoDeploy="true">
                <Valve className="org.apache.catalina.valves.AccessLogValve" directory="/var/log/tomcat7"
                    prefix="$(hostname)_access_log." suffix=".txt"
                    pattern="%h %l %u %t &quot;%r&quot; %s %b" />

            </Host>

        </Engine>

    </Service>

</Server>
EOF

/bin/sh -e /usr/tomcat/bin/catalina.sh run
