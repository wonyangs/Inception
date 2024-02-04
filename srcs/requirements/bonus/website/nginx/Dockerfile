FROM alpine:3.17

LABEL author wonyang

RUN apk add --no-cache nginx

COPY conf/default.conf /etc/nginx/http.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
