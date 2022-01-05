FROM demu/arm-java11:22.1.4.1

ENV LIFERAY_HOME /opt/liferay
ENV PATH $LIFERAY_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"

RUN set -eux; \
	\
# Create a new tomcat group
  groupadd tomcat; \
  useradd -s /bin/false -g tomcat -d $CATALINA_HOME tomcat; \
  \
  fileid="17ZnjU3URVHNXGO3E7dG9nldUQvs5sTZ4"
  filename="liferay.tar.gz"
  curl -c ./cookie -s -L "https://drive.google.com/uc?export=download&id=${fileid}" > /dev/null
  curl -Lb ./cookie "https://drive.google.com/uc?export=download&confirm=`awk '/download/ {print $NF}' ./cookie`&id=${fileid}" -o ${filename}

EXPOSE 8000 8009 8080 11311
