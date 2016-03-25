FROM centos:7
ENV container docker

RUN yum -y install unzip
RUN yum -y install wget
RUN yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel
RUN yum -y clean all

WORKDIR "/opt"
RUN wget http://download.jboss.org/wildfly/9.0.2.Final/wildfly-9.0.2.Final.zip
RUN wget https://www.dropbox.com/s/12exkegq5h3pm88/install-myfaces-2.2.9.cli?dl=0
RUN mv install-myfaces-2.2.9.cli?dl=0 install-myfaces-2.2.9.cli
RUN unzip wildfly-9.0.2.Final.zip
#RUN rm /opt/wildfly-9.0.2.Final.zip
#
ADD customization /opt/wildfly-9.0.2.Final/customization/
RUN chmod -v +x /opt/wildfly-9.0.2.Final/customization/setup_myfaces.sh
RUN /opt/wildfly-9.0.2.Final/customization/setup_myfaces.sh
ADD configuration/standalone.xml  /opt/wildfly-9.0.2.Final/standalone/configuration/


ADD my.war /opt/wildfly-9.0.2.Final/standalone/deployments
#copy the modules to wilfly
#ADD modules  /opt/wildfly-9.0.2.Final/

#unzip the modules firma into the wildfly modules
WORKDIR "/opt/wildfly-9.0.2.Final/modules"
#RUN unzip /opt/wildfly-9.0.2.Final/modulesFirma.zip
#RUN rm /opt/wildfly-9.0.2.Final/modulesFirma.zip

# create the folders structures
ADD configuration/structure.sh /opt/
RUN chmod  +x /opt/structure.sh
RUN /opt/structure.sh
RUN rm /opt/structure.sh

#ADD configuration/sign.zip /bancol/avaluos/

WORKDIR "/bancol/avaluos"
#RUN unzip -P  hElI04Sas sign.zip
#RUN rm sign.zip
#setup the wildfly credentials for web console
RUN /opt/wildfly-9.0.2.Final/bin/add-user.sh admin giadmin#1032 --silent
CMD ["/opt/wildfly-9.0.2.Final/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

WORKDIR "/"

EXPOSE 8080
EXPOSE 9990

# docker-machine ls
# http://192.168.99.100:8080/
# docker build --tag=gia-app-centos .
#docker run -it -p 8080:8080 -p 9990:9990  gia-app-centos
