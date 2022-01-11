FROM demu/tomcat8.5:22.1.11dev

ENV LIFERAY_HOME /usr/local
ENV PATH $LIFERAY_HOME/tomcat/bin:$PATH
ENV LIFERAY_DL_VERSION 7.4.3.5-ga5-20211221192828235

RUN mkdir -p "$LIFERAY_HOME"

RUN set -eux; \
	\
# Create a new tomcat group
  groupadd liferay; \
  useradd -s /bin/false -g liferay -d $LIFERAY_HOME liferay; \
  \
  curl -o liferay-ce-portal.war -L https://github.com/liferay/liferay-portal/releases/download/7.4.3.5-ga5/liferay-ce-portal-$LIFERAY_DL_VERSION.war; \
  rm -rf $LIFERAY_HOME/tomcat/webapps/*; \
  mkdir -p $LIFERAY_HOME/tomcat/webapps/ROOT; \
  mv liferay-ce-portal.war $LIFERAY_HOME/tomcat/webapps/ROOT; \
  jar -xvf $LIFERAY_HOME/tomcat/webapps/ROOT/liferay-ce-portal.war; \
  rm  $LIFERAY_HOME/tomcat/webapps/ROOT/liferay-ce-portal.war 
  
COPY bin/* /usr/local/tomcat/bin

EXPOSE 8000 8009 8080 11311

CMD ["catalina.sh", "run"]
