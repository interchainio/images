FROM alpine:3.9

COPY get-known-hosts /usr/bin
# `apk add ansible` installs PyYAML and `pip3 install awscli` fails because of dependency conflict.
# Instead of installing an older ansible from the package repository, we build a fresh version using pip.
RUN apk update && apk upgrade && apk add bash git py3-pip && \
    apk add python3-dev gcc musl-dev libffi-dev make openssl-dev && \
    pip3 install awscli ansible boto boto3 && \
    apk del python3-dev gcc musl-dev libffi-dev make openssl-dev && \
    ln -sf /usr/bin/python3 /usr/bin/python && \
    chmod +x /usr/bin/get-known-hosts && \
    adduser -D -u 3434 -s /bin/bash circleci

USER circleci:circleci
COPY --chown=circleci:circleci aws_config /home/circleci/.aws/config
SHELL ["/bin/bash", "-c"]
WORKDIR /home/circleci

