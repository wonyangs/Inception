FROM alpine:3.17

LABEL author wonyang

ARG RD_PASS

RUN apk update && apk upgrade && \
    apk add --no-cache redis && \
    sed -i "s|bind 127.0.0.1|bind 0.0.0.0|g"  /etc/redis.conf && \
    sed -i "s|# requirepass foobared|requirepass $RD_PASS|g"  /etc/redis.conf && \
    sed -i "s|# maxmemory <bytes>|maxmemory 256mb|g"  /etc/redis.conf && \
    echo "maxmemory-policy allkeys-lru" >> /etc/redis.conf

EXPOSE 6379

CMD [ "redis-server" , "/etc/redis.conf" ]
