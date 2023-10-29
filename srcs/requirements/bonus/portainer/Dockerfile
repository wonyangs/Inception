FROM alpine:3.17

RUN apk add --no-cache \
  ca-certificates \
  wget \
  tar

RUN wget https://github.com/portainer/portainer/releases/download/2.11.1/portainer-2.11.1-linux-amd64.tar.gz && \
  tar xzf portainer-2.11.1-linux-amd64.tar.gz && \
  rm portainer-2.11.1-linux-amd64.tar.gz && \
  chmod +x portainer/portainer

EXPOSE 9443

CMD ["./portainer/portainer", "-p", "9443"]
