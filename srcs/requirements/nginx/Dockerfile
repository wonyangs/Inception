FROM alpine:3.17

RUN	apk update && apk upgrade && apk add --no-cache nginx

EXPOSE 443

RUN apk add --no-cache tini

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["nginx", "-g", "daemon off;"]
