FROM alpine:3.17

RUN apk add --no-cache python3 py3-pip && \
    pip3 install --upgrade pip && \
    pip3 install django

RUN pip3 install tzdata

COPY ./requirements/bonus/website/django/mysite /var/www/mysite

CMD ["python3", "/var/www/mysite/manage.py", "runserver", "0.0.0.0:8000"]

