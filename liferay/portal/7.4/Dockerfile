FROM demu/java11:22.1.5ga

ENV LIFERAY_HOME /opt/liferay
ENV PATH $LIFERAY_HOME/tomcat-9.0.56/bin:$PATH
ENV LIFERAY_DL_VERSION 7.4.3.5-ga5-20211221192828235

RUN mkdir -p "$LIFERAY_HOME"

RUN set -eux; \
	\
# Create a new tomcat group
  groupadd liferay; \
  useradd -s /bin/false -g liferay -d $LIFERAY_HOME liferay; \
  \
  curl -o liferay-ce-portal.war -L https://github.com/liferay/liferay-portal/releases/download/7.4.3.5-ga5/liferay-ce-portal-$LIFERAY_DL_VERSION.war

EXPOSE 8000 8009 8080 11311

CMD ["catalina.sh", "run"]
