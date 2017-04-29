FROM debian:jessie-slim

ENV LANG C.UTF-8

RUN \
  apt-get update --yes && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends sudo curl ca-certificates git python-pip && \
  rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

RUN pip install git-cachecow
RUN mkdir /var/cache/git-cow && chmod 777 /var/cache/git-cow
ENV GIT_COW=/var/cache/git-cow
VOLUME $GIT_COW

COPY bin /usr/local/bin

RUN useradd -m user && rm ~user/.bashrc
USER user
WORKDIR /home/user
