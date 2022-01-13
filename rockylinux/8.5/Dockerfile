# Based on Rocky Linux
FROM demu/tomcat8.5:22.1.11dev

# Prepare infrastructure
RUN set -eux; \
	\
	dnf -y update && \
	dnf -y install vim && \
	dnf -y install tar; \
	sed -i "s|#set bell-style none|set bell-style none|g" /etc/inputrc
