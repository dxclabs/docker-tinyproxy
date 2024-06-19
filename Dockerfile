# tinyproxy
# Version: 1.0.0

FROM alpine:3.20

LABEL maintainer="Campbell McKilligan <campbell@dxclabs.com>"

ENV TINYPROXY_VERSION=1.11.2

RUN adduser -D -u 2000 -h /var/run/tinyproxy -s /sbin/nologin tinyproxy tinyproxy \
  && apk --update add -t build-dependencies \
    make \
    automake \
    autoconf \
    g++ \
    asciidoc \
    git \
  && rm -rf /var/cache/apk/* \
  && git clone -b ${TINYPROXY_VERSION} --depth=1 https://github.com/tinyproxy/tinyproxy.git /tmp/tinyproxy \
  && cd /tmp/tinyproxy \
  && ./autogen.sh \
  && ./configure --enable-transparent --prefix="" \
  && make \
  && make install \
  && mkdir -p /var/log/tinyproxy \
  && chown tinyproxy:tinyproxy /var/log/tinyproxy \
  && cd / \
  && rm -rf /tmp/tinyproxy \
  && apk del build-dependencies \
  && apk add --no-cache curl

COPY tinyproxy.conf /etc/tinyproxy/tinyproxy.conf
COPY docker-entrypoint.sh /docker-entrypoint.sh

USER tinyproxy

EXPOSE 8888

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD curl --fail -s -o /dev/null -H "Host: tinyproxy.stats" http://127.0.0.1:8888 || exit 1

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["tinyproxy", "-d"]
