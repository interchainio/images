FROM hashicorp/terraform:0.11.11

ENV TERRAGRUNT_VERSION=0.18.3
ENV STOML_VERSION=0.3.0
ENV STEMPLATE_VERSION=0.3.0
ENV SIGNALFORM_VERSION=0.0.1

RUN apk update && apk upgrade && apk add bash py3-pip && \
    pip3 install boto3 && \
    wget https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 -O /bin/terragrunt && chmod 755 /bin/terragrunt &&\
    wget https://github.com/freshautomations/stoml/releases/download/v${STOML_VERSION}/stoml_linux_amd64 -O /bin/stoml && chmod 755 /bin/stoml && \
    wget https://github.com/freshautomations/stemplate/releases/download/v${STEMPLATE_VERSION}/stemplate_linux_amd64 -O /bin/stemplate && chmod 755 /bin/stemplate && \
    wget https://github.com/freshautomations/terraform-provider-signalform/releases/download/v${SIGNALFORM_VERSION}/SHA256SUMS && \
    wget https://github.com/freshautomations/terraform-provider-signalform/releases/download/v${SIGNALFORM_VERSION}/terraform-provider-signalform_${SIGNALFORM_VERSION}_linux_amd64.tar.gz && \
    grep terraform-provider-signalform_${SIGNALFORM_VERSION}_linux_amd64.tar.gz SHA256SUMS > shacheck && \
    sha256sum -c shacheck && \
    tar -xzf terraform-provider-signalform_${SIGNALFORM_VERSION}_linux_amd64.tar.gz -C /bin && \
    rm SHA256SUMS terraform-provider-signalform_${SIGNALFORM_VERSION}_linux_amd64.tar.gz shacheck


ENTRYPOINT ["/bin/bash"]

