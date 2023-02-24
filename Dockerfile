FROM ubuntu:22.04
MAINTAINER sktechnologeisadl
RUN mkdir /opt/mysrc &&\
    apt update -y &&\
    apt install git -y &&\
    apt install curl -y &&\
    apt install default-jdk -y 
WORKDIR /opt/mysrc
RUN git clone https://github.com/sktechnologiesadl/warfile.git


# Install the Tomcat 
RUN mkdir /opt/tomcat

WORKDIR /opt/tomcat
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.72/bin/apache-tomcat-9.0.72.tar.gz .
RUN tar zxvf apache-tomcat-9.0.72.tar.gz &&\
    mv apache-tomcat-9.0.72/* /opt/tomcat/ &&\
    rm -rf apache-tomcat-9.0.72.tar.gz
EXPOSE 8080

# Copy the war file and config files 
WORKDIR /opt/mysrc/warfile
RUN cp maven-web-application.war /opt/tomcat/webapps/app.war &&\
    cp tomcat-users.xml /opt/tomcat/conf/tomcat-users.xml &&\
    cp context.xml /opt/tomcat/webapps/manager/META-INF/context.xml &&\
    cp contexth.xml /opt/tomcat/webapps/host-manager/META-INF/context.xml
# Start the Tomcat 
#RUN sh /opt/tomcat/bin/startup.sh 
WORKDIR /opt/tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
