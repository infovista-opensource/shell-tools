FROM alpine:3.20.3

RUN apk update \
&& apk upgrade \
&& apk add --no-cache \
	postgresql16-client=16.6-r0 \
yq-go=4.44.1-r2 \
jq=1.7.1-r0 \
curl=8.11.0-r2 \
bash=5.2.26-r0 \
&& rm -rf /var/cache/apk/*


RUN wget -O- -q https://github.com/mrako/wait-for/releases/download/v1.0.0/wait-for \
--output-document=/usr/local/bin/wait-for-1.0.0 \
&& wget https://dl.k8s.io/release/v1.31.2/bin/linux/amd64/kubectl  \
--output-document=/usr/local/bin/kubectl-v1.31.2 \
&& wget https://dl.min.io/client/mc/release/linux-amd64/archive/mc.RELEASE.2024-11-17T19-35-25Z \
--output-document=/usr/local/bin/mc.RELEASE.2024-11-17T19-35-25Z \
&& chmod +x /usr/local/bin/wait-for-1.0.0 \
&& ln -s /usr/local/bin/wait-for-1.0.0 /usr/local/bin/wait-for \
&& chmod +x /usr/local/bin/kubectl-v1.31.2 \
&& ln -s /usr/local/bin/kubectl-v1.31.2 /usr/local/bin/kubectl \
&& chmod +x /usr/local/bin/mc.RELEASE.2024-11-17T19-35-25Z \
&& ln -s /usr/local/bin/mc.RELEASE.2024-11-17T19-35-25Z /usr/local/bin/mc	\
&& mkdir -p /etc/mc \
&& chown -R 1001:1001 /etc/mc/

ENV MC_CONFIG_DIR="/etc/mc"

USER 1001:1001

