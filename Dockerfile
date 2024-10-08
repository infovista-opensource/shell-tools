FROM alpine:3.20.3

RUN apk update \
&& apk upgrade \
&& apk add --no-cache \
postgresql16-client=16.3-r0 \
yq-go=4.44.1-r2 \
jq=1.7.1-r0 \
curl=8.10.1-r0 \
bash=5.2.26-r0 \
&& rm -rf /var/cache/apk/*


RUN wget -O- -q https://github.com/mrako/wait-for/releases/download/v1.0.0/wait-for \
--output-document=/usr/local/bin/wait-for-1.0.0 \
&& wget https://dl.k8s.io/release/v1.31.1/bin/linux/amd64/kubectl  \
--output-document=/usr/local/bin/kubectl-v1.31.1 \
&& chmod +x /usr/local/bin/wait-for-1.0.0 \
&& ln -s /usr/local/bin/wait-for-1.0.0 /usr/local/bin/wait-for \
&& chmod +x /usr/local/bin/kubectl-v1.31.1 \
&& ln -s /usr/local/bin/kubectl-v1.31.1 /usr/local/bin/kubectl


USER 1001:1001
