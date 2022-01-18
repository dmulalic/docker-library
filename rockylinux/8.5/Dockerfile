# Based on Rocky Linux
FROM rockylinux/rockylinux:8.5

# Prepare infrastructure
RUN set -eux; \
	\
	dnf -y update && \
	dnf -y install vim && \
	dnf -y install tar && \
	dnf -y install unzip; \
	sed -i "s|#set bell-style none|set bell-style none|g" /etc/inputrc
