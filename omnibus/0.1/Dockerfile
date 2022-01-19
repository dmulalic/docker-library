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
  
COPY omnibus/assets/liferay/7.4/bin/* /usr/local/tomcat/bin/

EXPOSE 8080

CMD ["catalina.sh", "run"]
