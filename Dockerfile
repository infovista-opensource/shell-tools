FROM alpine:3.21.2

RUN apk update \
&& apk upgrade \
&& apk add --no-cache \
	postgresql16-client=16.6-r0 \
yq-go=4.44.5-r0 \
jq=1.7.1-r0 \
curl=8.11.1-r0 \
bash=5.2.37-r0 \
bind-tools=9.18.32-r0 \
&& rm -rf /var/cache/apk/*


RUN wget -O- -q https://github.com/mrako/wait-for/releases/download/v1.0.0/wait-for \
--output-document=/usr/local/bin/wait-for-1.0.0 \
&& wget https://dl.k8s.io/release/v1.32.1/bin/linux/amd64/kubectl  \
--output-document=/usr/local/bin/kubectl-v1.32.1 \
&& wget https://dl.min.io/client/mc/release/linux-amd64/archive/mc.RELEASE.2025-01-17T23-25-50Z \
--output-document=/usr/local/bin/mc.RELEASE.2025-01-17T23-25-50Z \
&& chmod +x /usr/local/bin/wait-for-1.0.0 \
&& ln -s /usr/local/bin/wait-for-1.0.0 /usr/local/bin/wait-for \
&& chmod +x /usr/local/bin/kubectl-v1.32.1 \
&& ln -s /usr/local/bin/kubectl-v1.32.1 /usr/local/bin/kubectl \
&& chmod +x /usr/local/bin/mc.RELEASE.2025-01-17T23-25-50Z \
&& ln -s /usr/local/bin/mc.RELEASE.2025-01-17T23-25-50Z /usr/local/bin/mc	\
&& mkdir -p /etc/mc \
&& chown -R 1001:1001 /etc/mc/

ENV MC_CONFIG_DIR="/etc/mc"

#USER 1001:1001

