FROM alpine:3.10.2

LABEL maintainer=brent@choozle.com

RUN apk add --update openssh-client && rm -rf /var/cache/apk/*

CMD ssh \
  -o StrictHostKeyChecking=no \
  -NL *:${LOCAL_PORT}:${REMOTE_HOST}:${REMOTE_PORT} \
  -i ${KEY_PATH} \
  -o TCPKeepAlive=yes \
  -o ConnectTimeout=5 \
  -o ServerAliveCountMax=10 \
  -o ServerAliveInterval=15 \
  ${SSH_USER}@${SSH_HOST}