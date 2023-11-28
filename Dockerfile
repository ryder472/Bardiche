FROM mcr.microsoft.com/devcontainers/typescript-node:1-20-bullseye as base
WORKDIR /app

ARG USERNAME=node
RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

COPY  . /app

USER node
RUN yarn

ENV DEVCONTAINER=true

# - - -

FROM gcr.io/distroless/nodejs20-debian12 as prd
ENV NODE_ENV production
COPY --from=base  --chown=nonroot:nonroot /app /app
USER nonroot

ENTRYPOINT ["/nodejs/bin/node", "build/main.js"]
