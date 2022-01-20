##### ROCK LINUX #####

# Based on Rocky Linux
FROM rockylinux/rockylinux:8.5

LABEL name="Omnibus Application Stack" \
	maintainer="demu" \
	release="0.1" \
	summary="Omnibus Application Stack" 

# Prepare infrastructure
RUN set -eux; \
	\
	dnf -y update && \
	dnf -y install vim && \
	dnf -y install tar && \
	dnf -y install unzip; \
	dnf -y install git; \
	sed -i "s|#set bell-style none|set bell-style none|g" /etc/inputrc
	
##### JAVA 11 #####

RUN yum update -y && \
    yum install -y java-11-openjdk java-11-openjdk-devel && \
    yum clean all

ENV JAVA_HOME /usr/lib/jvm/java

##### TOMCAT #####

ENV CATALINA_HOME /omnibus/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.5.73

RUN set -eux; \
	\
# Create a new tomcat group
	groupadd tomcat; \
	useradd -s /bin/false -g tomcat -d $CATALINA_HOME tomcat; \
	\
	curl -L "https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.73/bin/apache-tomcat-8.5.73.tar.gz" > tomcat.tar.gz; \
	\
	tar xzvf tomcat.tar.gz -C $CATALINA_HOME --strip-components=1; \
	rm -f tomcat.tar.gz; \
	\
	chgrp -R tomcat .; \
	chmod -R g+r conf; \
	chmod g+x conf; \
	chmod -R +rX .; \
	chmod 777 logs temp work; \
	chown -R tomcat webapps/ work/ temp/ logs/

##### LIFERAY #####

ENV LIFERAY_HOME /omnibus
ENV PATH $LIFERAY_HOME/tomcat/bin:$PATH
ENV LIFERAY_DL_VERSION 7.4.3.5-ga5-20211221192828235

WORKDIR $LIFERAY_HOME/tomcat/webapps/ROOT
RUN set -eux; \
	\
# Create a new tomcat group
	groupadd liferay; \
	useradd -s /bin/false -g liferay -d $LIFERAY_HOME liferay; \
	\
	rm -rf ./*; \
	curl -o liferay-ce-portal.war -L https://github.com/liferay/liferay-portal/releases/download/7.4.3.5-ga5/liferay-ce-portal-$LIFERAY_DL_VERSION.war; \
	jar -xvf liferay-ce-portal.war; \
	rm liferay-ce-portal.war
	
WORKDIR $LIFERAY_HOME
RUN set -eux; \
	\
	curl -o osgi.zip -L https://github.com/liferay/liferay-portal/releases/download/7.4.3.5-ga5/liferay-ce-portal-osgi-7.4.3.5-ga5-20211221192828235.zip; \
	unzip osgi.zip; \
	mv liferay-ce-portal-osgi-7.4.3.5-ga5 osgi; \
	rm osgi.zip
  
COPY assets/liferay/7.4/bin/* /omnibus/tomcat/bin/

##### GEOSERVER #####

WORKDIR $LIFERAY_HOME/tomcat/webapps/
RUN set -eux; \
	\
	curl -o geoserver.zip -L https://github.com/dmulalic/docker-library/releases/download/v0.1-dev/geoserver-2.20.1-war.zip; \
	unzip geoserver.zip; \
	rm geoserver.zip
	
##### KEYCLOAK ######

ENV KEYCLOAK_HOME /omnibus/keycloak
ENV KC_HOME /omnibus/keycloak
# RUN mkdir -p "$KEYCLOAK_HOME"
WORKDIR /omnibus
RUN set -eux; \
	\
	curl -o keycloak.zip -L https://github.com/keycloak/keycloak/releases/download/16.1.0/keycloak-16.1.0.zip; \
	unzip keycloak.zip; \
	mv keycloak-16.1.0 keycloak; \
	rm keycloak.zip; \
	/omnibus/keycloak/bin/add-user-keycloak.sh -u admin -p admin; \
	sed -i 's|jboss.http.port:8080|jboss.http.port:8090|' /omnibus/keycloak/standalone/configuration/standalone.xml
	# /omnibus/keycloak/bin/standalone.sh -Djboss.socket.binding.port-offset=10

##### ATHEOS ######
RUN set -eux; \
        \
        dnf -y install httpd && \
        dnf -y install php && \
	dnf -y install php-mbstring; \
	mkdir /atheos; \
	git clone https://github.com/atheos/atheos /atheos; \
	touch /atheos/config.php

# add healthcheck script
# COPY docker-healthcheck.sh /

# add launch script
COPY docker-entrypoint.sh /

EXPOSE 8080 8090

CMD ["/docker-entrypoint.sh"]
