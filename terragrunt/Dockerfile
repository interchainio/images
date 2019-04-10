FROM hashicorp/terraform:0.11.11

ENV TERRAGRUNT_VERSION=0.18.3
ENV STOML_VERSION=0.3.0
ENV STEMPLATE_VERSION=0.3.0

RUN apk update && apk upgrade && apk add bash py3-pip && \
    pip3 install boto3 && \
    wget https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 -O /bin/terragrunt && chmod 755 /bin/terragrunt &&\
    wget https://github.com/freshautomations/stoml/releases/download/v${STOML_VERSION}/stoml_linux_amd64 -O /bin/stoml && chmod 755 /bin/stoml && \
    wget https://github.com/freshautomations/stemplate/releases/download/v${STEMPLATE_VERSION}/stemplate_linux_amd64 -O /bin/stemplate && chmod 755 /bin/stemplate

ENTRYPOINT ["/bin/bash"]

