FROM circleci/node

USER root:root
RUN apt-get update && apt-get upgrade && apt-get install python3-pip jq && pip3 install awscli

USER circleci:circleci
COPY --chown=circleci:circleci aws_config /home/circleci/.aws/config
SHELL ["/bin/bash", "-c"]
WORKDIR /home/circleci

