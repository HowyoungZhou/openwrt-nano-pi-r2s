FROM ubuntu:18.04

RUN set -xe \
    && apt-get update \
    && apt-get install -y apt-utils tzdata locales
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
     && echo $TZ > /etc/timezone
RUN set -xe &&\
    dpkg-reconfigure --frontend=noninteractive tzdata && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt-get update && \
apt-get -y install build-essential asciidoc binutils bzip2 gawk \
gettext git libncurses5-dev libz-dev patch python3 python2.7 unzip \
zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core \
gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev \
xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint \
device-tree-compiler g++-multilib antlr3 gperf wget swig rsync

WORKDIR openwrt
COPY . .

RUN ./scripts/feeds update -a
RUN ./scripts/feeds install -a

CMD ["bash"]
