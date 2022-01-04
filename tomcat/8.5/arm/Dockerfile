FROM demu/arm-java11:22.1.4.1

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
  GDRIVE_FILE_ID=1VQ82S_GntuAtEx4pM8pYeJvPzCKL8erN; \
  DEST_PATH=tomcat.tar.gz; \
  curl -c ./cookie -s -L "https://drive.google.com/uc?export=download&id=${GDRIVE_FILE_ID}" > /dev/null; \
  curl -Lb ./cookie "https://drive.google.com/uc?export=download&confirm=`awk '/download/ {print $NF}' ./cookie`&id=${GDRIVE_FILE_ID}" -o ${DEST_PATH}; \
  rm -f cookie; \
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
