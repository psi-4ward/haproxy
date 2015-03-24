FROM webhippie/alpine:latest
MAINTAINER Thomas Boerger <thomas@webhippie.de>

ENV DISCOVERY_TYPE etcd
ENV DISCOVERY_HOST http://127.0.0.1
ENV DISCOVERY_PORT 4001
ENV DISCOVERY_INTERVAL 30
ENV DISCOVERY_PREFIX /

ENV HAPROXY_USERNAME webhippie
ENV HAPROXY_PASSWORD webhippie

RUN mkdir -p /docker

RUN apk-install \
  haproxy \
  curl

RUN mkdir -p /docker/libexec
ADD libexec /docker/libexec
RUN ln -sf /docker/libexec/manage /usr/bin/manage

RUN curl -sSL -o /usr/bin/confd https://github.com/kelseyhightower/confd/releases/download/v0.7.1/confd-0.7.1-linux-amd64
RUN chmod +x /usr/bin/confd
RUN mkdir -p /etc/confd/conf.d
RUN mkdir -p /etc/confd/templates

ADD confd/haproxy.toml /etc/confd/conf.d/haproxy.toml
ADD confd/haproxy.cfg.tmpl /etc/confd/templates/haproxy.cfg.tmpl

EXPOSE 80 443 9000

WORKDIR /docker
ENTRYPOINT ["manage"]
CMD ["bash"]
