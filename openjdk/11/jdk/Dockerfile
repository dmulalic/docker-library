FROM demu/rockylinux8.5

LABEL name="Java 11 image on Rocky Linux 8.5" \    
      maintainer="demu" \
      release="1" \
      summary="A Java 11 image based on Rocky Linux 8" 

RUN yum update -y && \
    yum install -y java-11-openjdk java-11-openjdk-devel && \
    yum clean all

ENV JAVA_HOME /usr/lib/jvm/java

CMD ["bash"]
