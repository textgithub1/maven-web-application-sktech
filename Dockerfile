FROM ubuntu:18.04
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
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.70/bin/apache-tomcat-9.0.70.tar.gz .
RUN tar zxvf apache-tomcat-9.0.70.tar.gz &&\
    mv apache-tomcat-9.0.70/* /opt/tomcat/ &&\
    rm -rf apache-tomcat-9.0.70.tar.gz
EXPOSE 8080
RUN cp /opt/mysrc/warfile/maven-web-application.war /opt/tomcat/webapps/app.war 

# Start the Tomcat 
#RUN sh /opt/tomcat/bin/startup.sh 
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
