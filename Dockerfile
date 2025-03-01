FROM alpine:3.21.3

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


RUN wget -O- -q https://github.com/mrako/wait-for/releases/download/v1.0.0/wait-for \
--output-document=/usr/local/bin/wait-for-1.0.0 \
&& wget https://dl.k8s.io/release/v1.32.2/bin/linux/amd64/kubectl  \
--output-document=/usr/local/bin/kubectl-v1.32.2 \
&& wget https://dl.min.io/client/mc/release/linux-amd64/archive/mc.RELEASE.2025-02-08T19-14-21Z \
--output-document=/usr/local/bin/mc.RELEASE.2025-02-08T19-14-21Z \
&& chmod +x /usr/local/bin/wait-for-1.0.0 \
&& ln -s /usr/local/bin/wait-for-1.0.0 /usr/local/bin/wait-for \
&& chmod +x /usr/local/bin/kubectl-v1.32.2 \
&& ln -s /usr/local/bin/kubectl-v1.32.2 /usr/local/bin/kubectl \
&& chmod +x /usr/local/bin/mc.RELEASE.2025-02-08T19-14-21Z \
&& ln -s /usr/local/bin/mc.RELEASE.2025-02-08T19-14-21Z /usr/local/bin/mc	\
&& mkdir -p /etc/mc \
&& chown -R 1001:1001 /etc/mc/

ENV MC_CONFIG_DIR="/etc/mc"

#USER 1001:1001

