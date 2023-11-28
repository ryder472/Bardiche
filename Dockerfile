FROM mcr.microsoft.com/devcontainers/typescript-node:1-20-bullseye as base
WORKDIR /app

# - - -

FROM base as dev

ARG USERNAME=node
RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

COPY --chown=node:node  . /app
RUN yarn install

ENV DEVCONTAINER=true

# - - -

FROM base as actions

COPY . /app

# - - -

FROM gcr.io/distroless/nodejs20-debian12 as prd
ENV NODE_ENV production
COPY --from=actions  --chown=nonroot:nonroot /app /app
USER nonroot

ENTRYPOINT ["/nodejs/bin/node", "build/main.js"]
