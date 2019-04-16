FROM alpine:3.9

ENV STAKE_DIST_VERSION=1.1.0

RUN apk update && apk upgrade && apk add bash ruby git && \
    gem install rdoc || gem install network && \
    gem install rdoc && \
    gem install twurl && \
    wget https://github.com/interchainio/delegation/releases/download/v${STAKE_DIST_VERSION}/stake-dist_v${STAKE_DIST_VERSION}_linux_amd64 -O /usr/bin/stake-dist && \
    chmod +x /usr/bin/stake-dist && \
    adduser -D -u 3434 -s /bin/bash circleci

USER circleci:circleci
SHELL ["/bin/bash", "-c"]
WORKDIR /home/circleci

