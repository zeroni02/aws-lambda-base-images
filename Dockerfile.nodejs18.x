FROM scratch
ADD x86_64/21c449924c1f1dc9eac652d23d0dfb5b59990ca356bd3468c1d4c619fa73cd52.tar.xz /
ADD x86_64/22d59aa54b65360b84ef30fef2b89a2c1621f8c76ba7c0bfb5e3b6e927f063ae.tar.xz /
ADD x86_64/2f97f3d5b8e0c78977fdbcd26df20bfef85a599fcd0b1442c3c56472b1ec41ad.tar.xz /
ADD x86_64/78a4419835daefc8deffedf3219783e7d91eba0886b8147025d505bdbaf0e9d9.tar.xz /
ADD x86_64/80c057aa0a5b7e97f38c607573dae2a82944a7a6c6531589b77987f068a5563b.tar.xz /
ADD x86_64/93661b2b6c8ea08a0595e46a576884ea04255b6365ac39de4a4559a8784b5409.tar.xz /

ENV VERSION_AMPLIFY=7.6.14
ENV VERSION_YARN=1.22.19

ENV LANG=en_US.UTF-8
ENV TZ=:/etc/localtime
ENV PATH=/var/lang/bin:/usr/local/bin:/usr/bin/:/bin:/opt/bin

RUN yum -y update && \
    yum -y install \
        git python3 make gcc* \
    yum clean all && \
    rm -rf /var/cache/yum

RUN /bin/bash -c "npm install -g yarn@${VERSION_YARN}"

RUN /bin/bash -c "npm install -g @aws-amplify/cli@${VERSION_AMPLIFY}"

ENTRYPOINT [ "bash", "-c" ]
