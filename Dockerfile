ARG ALPINE_VERSION="3.23.4"



FROM alpine:${ALPINE_VERSION}

ARG POSTGRESQL_VERSION="18"
ARG WAIT4_VERSION="1.0.0"
ARG WAIT4X_VERSION="3.6.0"
ARG HELM_VERSION="4.2.0"
ARG KUBECTL_VERSION="1.36.1"
ARG MC_VERSION="RELEASE.2025-08-13T08-35-41Z"

RUN apk add --no-cache \
postgresql${POSTGRESQL_VERSION}-client \
yq-go \
jq \
curl \
bash \
bind-tools

RUN addgroup -g 1001 iv && adduser -D -G iv -u 1001 iv

RUN wget -q -O /usr/local/bin/wait-for-${WAIT4_VERSION} \
  https://github.com/mrako/wait-for/releases/download/v${WAIT4_VERSION}/wait-for \
&& wget -q -O /tmp/wait4x-linux-amd64.tar.gz \
  https://github.com/wait4x/wait4x/releases/download/v${WAIT4X_VERSION}/wait4x-linux-amd64.tar.gz \
&& mkdir /tmp/wait4x && tar -xvf /tmp/wait4x-linux-amd64.tar.gz -C /tmp/wait4x \
&& mv /tmp/wait4x/wait4x /usr/local/bin/wait4x-${WAIT4X_VERSION} \
&& rm -rf /tmp/wait4x /tmp/wait4x-linux-amd64.tar.gz \
&& wget -q -O /tmp/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
  https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
&& mkdir /tmp/helm && tar -xvf /tmp/helm-v${HELM_VERSION}-linux-amd64.tar.gz -C /tmp/helm \
&& mv /tmp/helm/linux-amd64/helm /usr/local/bin/helm-v${HELM_VERSION} \
&& rm -rf /tmp/helm /tmp/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
&& wget -q -O /usr/local/bin/kubectl-v${KUBECTL_VERSION} \
  https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
&& wget -q -O /usr/local/bin/mc.${MC_VERSION} \
  https://dl.min.io/client/mc/release/linux-amd64/archive/mc.${MC_VERSION} \
&& chmod +x /usr/local/bin/wait4x-${WAIT4X_VERSION} \
&& ln -s /usr/local/bin/wait4x-${WAIT4X_VERSION} /usr/local/bin/wait4x \
&& chmod +x /usr/local/bin/wait-for-${WAIT4_VERSION} \
&& ln -s /usr/local/bin/wait-for-${WAIT4_VERSION} /usr/local/bin/wait-for \
&& chmod +x /usr/local/bin/helm-v${HELM_VERSION} \
&& ln -s /usr/local/bin/helm-v${HELM_VERSION} /usr/local/bin/helm \
&& chmod +x /usr/local/bin/kubectl-v${KUBECTL_VERSION} \
&& ln -s /usr/local/bin/kubectl-v${KUBECTL_VERSION} /usr/local/bin/kubectl \
&& chmod +x /usr/local/bin/mc.${MC_VERSION} \
&& ln -s /usr/local/bin/mc.${MC_VERSION} /usr/local/bin/mc \
&& mkdir -p /etc/mc \
&& chown -R 1001:1001 /etc/mc/

ENV MC_CONFIG_DIR="/etc/mc"

USER 1001:1001

