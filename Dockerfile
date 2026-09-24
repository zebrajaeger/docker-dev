ARG NVM_VERSION=v0.40.3
ARG NODE_VERSION=24
ARG JAVA_VERSION=17

FROM ubuntu:24.04

ARG NVM_VERSION
ARG NODE_VERSION
ARG JAVA_VERSION

RUN apt-get update && apt-get install -y \
    sudo \
    openssh-client \
    openssh-server \
    git \
    curl \
    ca-certificates \
    gnupg \
    maven \
    && rm -rf /var/lib/apt/lists/*

# SAPMachine
RUN curl -fsSL https://dist.sapmachine.io/debian/sapmachine.key \
      | gpg --dearmor -o /usr/share/keyrings/sapmachine.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/sapmachine.gpg] https://dist.sapmachine.io/debian/amd64/ /" \
      > /etc/apt/sources.list.d/sapmachine.list \
    && apt-get update \
    && apt-get install -y "sapmachine-${JAVA_VERSION}-jdk" \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash developer \
    && mkdir -p /run/sshd \
    && mkdir -p /home/developer/.ssh \
    && chmod 700 /home/developer/.ssh \
    && chown -R developer:developer /home/developer/.ssh

RUN usermod -aG sudo developer \
    && echo 'developer ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/developer \
    && chmod 440 /etc/sudoers.d/developer

ENV NVM_DIR=/home/developer/.nvm

RUN mkdir -p "$NVM_DIR" \
    && chown -R developer:developer "$NVM_DIR"

USER developer

RUN curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash \
    && . "$NVM_DIR/nvm.sh" \
    && nvm install "$NODE_VERSION" \
    && nvm alias default "$NODE_VERSION"

USER root

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN sed -i 's/\r$//' /usr/local/bin/entrypoint.sh \
    && chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /workspace

EXPOSE 22

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/usr/sbin/sshd", "-D", "-e"]
