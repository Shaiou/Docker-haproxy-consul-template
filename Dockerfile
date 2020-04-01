# Inspired by https://github.com/camptocamp/docker-haproxy-consul
FROM haproxy:2.0-alpine
ARG CONSUL_TEMPLATE_VERSION=0.18.1
ENV CONSUL_ADDR localhost:8500

ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip /
RUN apk update && \
    apk add --no-cache --quiet zip && \
    unzip /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip &&\
    mv /consul-template /usr/local/bin/consul-template && \
    rm -rf /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
    apk del zip 

RUN mkdir -p /etc/consul-template /etc/haproxy
ADD consul-template.cfg /etc/consul-template/
ADD haproxy.cfg.tpl /etc/haproxy

CMD ["/usr/local/bin/consul-template", "-consul-addr", "${CONSUL_ADDR}"]
