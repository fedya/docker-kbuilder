FROM ubuntu
MAINTAINER alexander@mezon.ru

# Install apt based dependencies required to build kernel
RUN apt-get update \
   && DEBIAN_FRONTEND=noninteractive \
   && dpkg --add-architecture i386 \
   && apt-get update \
   && apt-get install -y git wget bc build-essential device-tree-compiler fakeroot lzma lzop man-db libncurses5-dev:amd64 libc6:i386 libncurses5:i386 libstdc++6:i386 zlib1g:i386 \
   && git config --global user.email "builder@eewiki.net" \
   && git config --global user.name "docker kernel builder"

COPY entrypoint.sh /sbin/entrypoint.sh
ENTRYPOINT ["/sbin/entrypoint.sh"]
