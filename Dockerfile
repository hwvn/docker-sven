FROM python:3.6.5-alpine3.4

RUN addgroup -g 1001 -S uwsgi && adduser -u 1001 -S -G uwsgi uwsgi && \
    apk add --no-cache  'su-exec>=0.2'
    
RUN set -ex \
    && apk add --no-cache --update \
    build-base \
    gcc \
    make \
    libc-dev \
    musl-dev \
    linux-headers \
    pcre-dev \
    zlib-dev \
    libffi-dev \
    libffi \
    gdk-pixbuf \
    jpeg-dev \
    freetype-dev \
    postgresql-dev \
    python3-dev \
    libmagic \
    ffmpeg \
    git \
    nodejs \
    curl \
  && rm -rf /var/cache/apk/*

RUN curl https://bootstrap.pypa.io/get-pip.py | python

RUN pip install uwsgi

COPY ./requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt
ENV PYTHONUNBUFFERED=1