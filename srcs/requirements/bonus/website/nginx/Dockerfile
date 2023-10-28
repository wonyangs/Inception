FROM alpine:3.17

RUN apk add --no-cache nginx

COPY ./requirements/bonus/website/nginx/conf/default.conf /etc/nginx/http.d/default.conf

CMD ["nginx", "-g", "daemon off;"]

