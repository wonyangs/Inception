FROM alpine:3.17

RUN apk update && apk upgrade && \
    apk add --no-cache redis && \
    sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g"  /etc/redis.conf && \
    sed -i "s|# maxmemory <bytes>|maxmemory 20mb|g"  /etc/redis.conf && \
    echo "maxmemory-policy allkeys-lru" >> /etc/redis.conf

EXPOSE 6379

RUN apk add --no-cache tini

ENTRYPOINT ["/sbin/tini", "--"]
CMD [ "redis-server" , "/etc/redis.conf" ]
