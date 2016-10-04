FROM alpine:3.4
MAINTAINER Sebastian Herzberg <s.herzberg@mytaxi.com>
ENV PATH=$PATH:$CATALINA_HOME/bin \
    TERM=xterm \
    CATALINA_HOME=/usr/tomcat \
    JAVA_HOME="/usr/lib/jvm/java-1.7-openjdk/jre" \
    TOMCAT_VERSION=7.0.72

RUN apk add --no-cache openjdk7-jre-base curl ca-certificates bash openssh openssl
RUN curl --silent --location --retry 3 --cacert /etc/ssl/certs/ca-certificates.crt \
    "http://ftp.halifax.rwth-aachen.de/apache/tomcat/tomcat-7/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz" \
    | gunzip | tar x -C /usr/ &&\
    mv /usr/apache-tomcat* /usr/tomcat &&\
    rm -rf /usr/tomcat/webapps/examples /usr/tomcat/webapps/docs /usr/tomcat/webapps/ROOT

RUN mkdir -p /opt/myt

COPY build/setenv.sh /usr/tomcat/bin/setenv.sh
COPY build/usr_tomcat_lib/ /usr/tomcat/lib/
COPY build/cacerts /usr/lib/jvm/java-1.7-openjdk/jre/lib/security

COPY ./run.sh /usr/local/bin/run
EXPOSE 5555 8080

ENTRYPOINT [ "/bin/sh", "-c" ]
CMD ["/usr/local/bin/run"]
