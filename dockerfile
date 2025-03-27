# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine:3.21

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
    -r https://raw.githubusercontent.com/trackstacker/meloday/refs/heads/main/requirements.txt && \
  git clone https://github.com/trackstacker/meloday.git && \
  echo "**** cleanup ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /tmp/* \
    $HOME/.cache

# copy local files
COPY root/ /

# volumes
VOLUME /config