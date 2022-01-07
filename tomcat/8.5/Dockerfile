FROM demu/java11:22.1.5ga

ENV CATALINA_HOME /usr/local/tomcat
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
	curl -L "https://drive.google.com/uc?id=1wFVBSL1VaUA2pKAzZxOrrful_dW8Xpac&export=download" > tomcat.tar.gz; \
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

EXPOSE 8080

CMD ["catalina.sh", "run"]
