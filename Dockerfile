FROM ubuntu:18.04

ARG USER_ID
ARG GID

# Create user
RUN groupadd -g $GID docker-users && \
    useradd -m --no-log-init -s /bin/bash -u $USER_ID -g $GID docker && \
    echo "docker:docker" | chpasswd && \
    adduser docker sudo

#install OpenJDK 8
ENV JAVA_HOME=/opt/java/openjdk
COPY --from=eclipse-temurin:8 $JAVA_HOME $JAVA_HOME
ENV PATH="${JAVA_HOME}/bin:${PATH}"

#edit jave setting
RUN sed -i "s|jdk.tls.disabledAlgorithms=SSLv3, TLSv1, TLSv1.1, RC4, DES, MD5withRSA, \\\|jdk.tls.disabledAlgorithms=SSLv3, RC4, DES, MD5withRSA, \\\|g" /opt/java/openjdk/jre/lib/security/java.security


#install package required by Android AOSP
RUN apt update
RUN apt-get -y install git-core gnupg flex bison build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 libncurses5 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig

#install python 2
RUN apt update
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt update
RUN apt-get -y install python-pip

#install mkimage
RUN apt-get -y install u-boot-tools

#install pacages
RUN apt-get -y install bc git lzop sudo vim rsync lsof

USER docker
