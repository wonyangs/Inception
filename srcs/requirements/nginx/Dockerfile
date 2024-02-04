FROM alpine:3.17

LABEL author wonyang

RUN	apk update && apk upgrade && apk add --no-cache nginx

RUN sed -i "s|ssl_protocols TLSv1.1 TLSv1.2 TLSv1.3;|ssl_protocols TLSv1.2 TLSv1.3;|g" \
      /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
