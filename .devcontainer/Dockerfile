FROM mcr.microsoft.com/devcontainers/typescript-node:1-20-bullseye

WORKDIR /app

RUN sudo apt update && sudo apt install -y less man-db sudo

ARG USERNAME=node
RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

ENV DEVCONTAINER=true