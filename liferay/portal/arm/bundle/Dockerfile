FROM demu/arm-java11:22.1.4.1

ENV LIFERAY_HOME /opt/liferay
ENV PATH $LIFERAY_HOME/bin:$PATH
RUN mkdir -p "$LIFERAY_HOME"

RUN set -eux; \
	\
# Create a new tomcat group
  groupadd liferay; \
  useradd -s /bin/false -g liferay -d $LIFERAY_HOME liferay; \
  \
  fileid="17ZnjU3URVHNXGO3E7dG9nldUQvs5sTZ4"; \
  filename="liferay.tar.gz"; \
  curl -c ./cookie -s -L "https://drive.google.com/uc?export=download&id=${fileid}" > /dev/null; \
  curl -Lb ./cookie "https://drive.google.com/uc?export=download&confirm=`awk '/download/ {print $NF}' ./cookie`&id=${fileid}" -o ${filename}; \
  \
  tar xzvf liferay.tar.gz -C $LIFERAY_HOME --strip-components=1; \
  rm -f liferay.tar.gz

EXPOSE 8000 8009 8080 11311

CMD ["catalina.sh", "run"]
