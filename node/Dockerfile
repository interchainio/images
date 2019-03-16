FROM circleci/node

ENV CHAMBER_VERSION=2.3.2

USER root:root
RUN wget https://github.com/segmentio/chamber/releases/download/v${CHAMBER_VERSION}/chamber-v${CHAMBER_VERSION}-linux-amd64 && \
    wget https://github.com/segmentio/chamber/releases/download/v${CHAMBER_VERSION}/chamber-v${CHAMBER_VERSION}.sha256sums && \
    grep linux chamber-v${CHAMBER_VERSION}.sha256sums | shasum -a 256 -c - && \
    rm chamber-v${CHAMBER_VERSION}.sha256sums && \
    mv chamber-v${CHAMBER_VERSION}-linux-amd64 /bin/chamber && \
    chmod +x /bin/chamber && \
    apt-get update && apt-get upgrade && apt-get install awscli

USER circleci:circleci
SHELL ["/bin/bash", "-c"]
WORKDIR /home/circleci

