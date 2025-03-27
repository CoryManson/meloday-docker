# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine:3.21

# copy all necessary files in a single step
COPY requirements.txt /tmp/requirements.txt

RUN \
  echo "**** install build packages ****" && \
  apk add --no-cache --virtual=build-dependencies \
    openssl-dev \
    python3-dev \
    git && \
  echo "**** install runtime packages ****" && \
  apk add --no-cache \
    gnupg \
    python3 \
    py3-pip && \
  echo "**** verify installed packages ****" && \
  python3 --version && \
  pip --version && \
  git --version && \
  echo "**** install app ****" && \
  python3 -m venv /lsiopy && \
  /lsiopy/bin/pip install -U --no-cache-dir \
    pip \
    wheel && \
  /lsiopy/bin/pip install -U --no-cache-dir --find-links https://wheel-index.linuxserver.io/alpine-3.21/ \
    -r /tmp/requirements.txt && \
  echo "**** cleanup ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /tmp/* \
    $HOME/.cache

# copy all necessary files in a single step
COPY root/ /
COPY meloday.py /tmp/meloday.py
COPY assets/ /tmp/assets/
COPY config.yml /tmp/config.yml

# volumes
VOLUME /config