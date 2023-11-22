FROM mcr.microsoft.com/devcontainers/typescript-node:1-20-bullseye as base
WORKDIR /app

#RUN sudo apt update && sudo apt install -y less man-db sudo
#
ARG USERNAME=node
RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

COPY --chown=node:node . /app

USER node
RUN yarn

ENV DEVCONTAINER=true

# - - -

FROM gcr.io/distroless/nodejs20-debian12
ENV NODE_ENV production
COPY --from=base  --chown=nonroot:nonroot /app /app
USER nonroot

ENTRYPOINT ["/nodejs/bin/node", "build/main.js"]
