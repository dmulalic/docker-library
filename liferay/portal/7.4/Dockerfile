FROM demu/tomcat8.5:22.1.11dev

ENV LIFERAY_HOME /usr/local
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
# rm liferay-ce-portal.war 
  
COPY bin/* /usr/local/tomcat/bin/

EXPOSE 8000 8009 8080 11311

CMD ["catalina.sh", "run"]
