FROM circleci/node

ENV CHAMBER_VERSION=2.3.2
ENV AWS_VAULT_VERSION=4.5.1

USER root:root
RUN wget https://github.com/segmentio/chamber/releases/download/v${CHAMBER_VERSION}/chamber-v${CHAMBER_VERSION}-linux-amd64 && \
    wget https://github.com/segmentio/chamber/releases/download/v${CHAMBER_VERSION}/chamber-v${CHAMBER_VERSION}.sha256sums && \
    grep linux chamber-v${CHAMBER_VERSION}.sha256sums | shasum -a 256 -c - && \
    rm chamber-v${CHAMBER_VERSION}.sha256sums && \
    mv chamber-v${CHAMBER_VERSION}-linux-amd64 /bin/chamber && \
    chmod +x /bin/chamber && \
    wget https://github.com/99designs/aws-vault/releases/download/v${AWS_VAULT_VERSION}/aws-vault-linux-amd64 -O /bin/aws-vault && \
    chmod +x /bin/aws-vault

COPY --chown=circleci:circleci aws_config /home/circleci/.aws/config
RUN apt-get update && apt-get upgrade && apt-get install python3-pip && pip3 install awscli

USER circleci:circleci
SHELL ["/bin/bash", "-c"]
WORKDIR /home/circleci

