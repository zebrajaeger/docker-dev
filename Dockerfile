ARG NVM_VERSION=v0.40.3
ARG NODE_VERSION=24
ARG JAVA_VERSION=17

FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    sudo \
    openssh-client \
    openssh-server \
    git \
    curl \
    ca-certificates \
    openjdk-17-jdk \
    maven \
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
    && nvm install 24 \
    && nvm alias default 24

USER root

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN sed -i 's/\r$//' /usr/local/bin/entrypoint.sh \
    && chmod +x /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /workspace

EXPOSE 22

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/usr/sbin/sshd", "-D", "-e"]