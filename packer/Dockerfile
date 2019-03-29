FROM alpine:3.9

ENV PACKER_VERSION=1.3.5

RUN apk update && apk upgrade && apk add jq ansible git && \
    wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip && \
    wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS && \
    grep packer_${PACKER_VERSION}_linux_amd64.zip packer_${PACKER_VERSION}_SHA256SUMS > packer_linux_sha && \
    sha256sum -c packer_linux_sha && \
    unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/bin && \
    rm packer_${PACKER_VERSION}_linux_amd64.zip packer_${PACKER_VERSION}_SHA256SUMS packer_linux_sha && \
    adduser -D -u 3434 -s /bin/bash circleci

USER circleci:circleci
COPY --chown=circleci:circleci aws_config /home/circleci/.aws/config
SHELL ["/bin/bash", "-c"]
WORKDIR /home/circleci

