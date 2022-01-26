FROM debian:buster

RUN apt-get update &&\
    apt-get install -y \
        sudo time git-core subversion build-essential g++ bash make \
        libssl-dev patch libncurses5 libncurses5-dev zlib1g-dev gawk \
        flex gettext wget unzip xz-utils python python-distutils-extra \
        python3 python3-distutils-extra rsync curl libsnmp-dev liblzma-dev \
        libpam0g-dev cpio rsync libjson-c-dev && \
    apt-get clean && \
    useradd -m build && \
    echo 'build ALL=NOPASSWD: ALL' > /etc/sudoers.d/user

USER build
WORKDIR /home/build
COPY build.sh /build.sh

ENV OPENWRT_VERSION=v21.02.1

RUN git config --global user.name "build" && git config --global user.email "build@localhost"
CMD /bin/bash /build.sh
