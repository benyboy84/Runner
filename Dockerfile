FROM myoung34/github-runner:2.299.0

ARG TARGETOS TARGETARCH

ARG TF_VERSION=1.3.4
ARG TFLINT_VERSION=0.42.2
ARG TG_VERSION=0.42.5

RUN apt-get update

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

RUN apt-get install -y --no-install-recommends \
    curl wget unzip vim git jq build-essential libssl-dev libffi-dev python3 python3-venv python3-dev python3-pip

RUN wget --quiet https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip \
  && unzip terraform_${TF_VERSION}_linux_amd64.zip \
  && mv terraform /usr/local/bin \
  && rm terraform_${TF_VERSION}_linux_amd64.zip

RUN wget -O /tmp/tflint.zip https://github.com/terraform-linters/tflint/releases/download/v"${TFLINT_VERSION}"/tflint_linux_amd64.zip \
  && unzip /tmp/tflint.zip -d /usr/local/bin \
  && rm /tmp/tflint.zip

RUN pip3 install checkov

# Get Terragrunt by a specific version or search for the latest one
# Install terragrunt in the runner
RUN curl -o /usr/local/bin/terragrunt -fsSL "https://github.com/gruntwork-io/terragrunt/releases/download/v"${TG_VERSION}"/terragrunt_linux_amd64" \
 && chmod +x /usr/local/bin/terragrunt
