FROM alpine:3.17

LABEL author wonyang

ARG DJANGO_SECRET_KEY \
    DJANGO_DEBUG \
    DATABASE_URL

RUN apk add --no-cache python3 py3-pip && \
    pip3 install --upgrade pip && \
    pip3 install django

RUN pip3 install tzdata django-environ

COPY mysite /var/www/mysite

RUN python3 /var/www/mysite/manage.py collectstatic --no-input

CMD ["python3", "/var/www/mysite/manage.py", "runserver", "0.0.0.0:8000"]
