FROM alpine:3.9

ENV STAKE_DIST_VERSION=2.0.0
ENV STEMPLATE_VERSION=0.3.0

RUN apk update && apk upgrade && apk add bash ruby && \
    gem install network twurl --no-document && \
    apk add gcc make ruby-dev libc-dev && gem install json --no-document && apk del gcc make ruby-dev libc-dev && \
    wget https://github.com/interchainio/delegation/releases/download/v${STAKE_DIST_VERSION}/stake-dist_v${STAKE_DIST_VERSION}_linux_amd64 -O /usr/bin/stake-dist && \
    wget https://github.com/freshautomations/stemplate/releases/download/v${STEMPLATE_VERSION}/stemplate_linux_amd64 -O /usr/bin/stemplate && \
    chmod +x /usr/bin/stake-dist /usr/bin/stemplate && \
    adduser -D -u 3434 -s /bin/bash circleci

USER circleci:circleci
SHELL ["/bin/bash", "-c"]
WORKDIR /home/circleci

