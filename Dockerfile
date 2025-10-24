FROM alpine:3.22.2

RUN apk update \
&& apk upgrade \
&& apk add --no-cache \
postgresql16-client \
yq-go \
jq \
curl \
bash \
bind-tools \
&& rm -rf /var/cache/apk/*

RUN addgroup -g 1001 iv && adduser -D -G iv -u 1001 iv

RUN wget -O- -q https://github.com/mrako/wait-for/releases/download/v1.0.0/wait-for \
--output-document=/usr/local/bin/wait-for-1.0.0 \
&& wget -O- -q https://github.com/wait4x/wait4x/releases/download/v3.6.0/wait4x-linux-amd64.tar.gz \
--output-document=/tmp/wait4x-linux-amd64.tar.gz \
&& mkdir /tmp/wait4x && tar -xvf /tmp/wait4x-linux-amd64.tar.gz -C /tmp/wait4x \
&& mv /tmp/wait4x/wait4x /usr/local/bin/wait4x-3.6.0 \
&& rm -rf /tmp/wait4x /tmp/wait4x-linux-amd64.tar.gz \
&& wget https://dl.k8s.io/release/v1.34.0/bin/linux/amd64/kubectl  \
--output-document=/usr/local/bin/kubectl-v1.34.0 \
&& wget https://dl.min.io/client/mc/release/linux-amd64/archive/mc.RELEASE.2025-08-13T08-35-41Z \
--output-document=/usr/local/bin/mc.RELEASE.2025-08-13T08-35-41Z \
&& chmod +x /usr/local/bin/wait4x-3.6.0 \
&& ln -s /usr/local/bin/wait4x-3.6.0 /usr/local/bin/wait4x \
&& chmod +x /usr/local/bin/wait-for-1.0.0 \
&& ln -s /usr/local/bin/wait-for-1.0.0 /usr/local/bin/wait-for \
&& chmod +x /usr/local/bin/kubectl-v1.34.0 \
&& ln -s /usr/local/bin/kubectl-v1.34.0 /usr/local/bin/kubectl \
&& chmod +x /usr/local/bin/mc.RELEASE.2025-08-13T08-35-41Z \
&& ln -s /usr/local/bin/mc.RELEASE.2025-08-13T08-35-41Z /usr/local/bin/mc	\
&& mkdir -p /etc/mc \
&& chown -R 1001:1001 /etc/mc/

ENV MC_CONFIG_DIR="/etc/mc"

USER 1001:1001

