FROM alpine:3.7

ARG TAG
LABEL TAG=${TAG}

LABEL maintainer="mzum@mzum.org"

WORKDIR /tmp

# Get Alpine Repo and Run Packages, dl-5.alpinelinux.org is down now
RUN set -ex; \
    echo "*** Get apk repos from alpine sites ***"; \
    echo http://dl-4.alpinelinux.org/alpine/v3.7/main > /etc/apk/repositories; \
    echo http://dl-4.alpinelinux.org/alpine/v3.7/community >> /etc/apk/repositories

RUN set -ex; \
    echo "*** Update and upgrade apk repos ***"; \
    apk update; \
    apk upgrade

RUN set -ex; \
    echo "*** Install basic apk packages ***"; \
    apk add --no-cache openjdk8-jre tini su-exec wget curl net-tools unzip libzmq bash file; \
    apk add --no-cache net-tools file htop atop glances tcpdump smem; \
    apk add --no-cache -t .build-deps ca-certificates gnupg openssl; \
    apk update; \
    apk upgrade
    
EXPOSE 8080

ENTRYPOINT ["/bin/bash"]
#
#ENTRYPOINT ["/sbin/tini", "--", "/bin/bash"]
#CMD ["top"]
