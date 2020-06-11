FROM elixir:1.10-alpine as builder

ENV MIX_ENV prod

WORKDIR /opt/app

RUN apk update && \
  apk upgrade --no-cache && \
  apk add --no-cache \
  build-base \
  nodejs \
  yarn && \
  mix local.rebar --force && \
  mix local.hex --force

ADD . .

RUN mix do deps.get, deps.compile, compile

RUN rel/assets.sh && mix phx.digest

RUN mkdir -p /opt/release && \
  mix release revista_unified && \
  RELEASE=$(ls -d _build/prod/revista_unified-*.tar.gz) && \
  cp $RELEASE /opt/release/revista_unified.tar.gz && \
  cd /opt/release && \
  tar -xzf revista_unified.tar.gz && \
  rm revista_unified.tar.gz

FROM alpine:3.12

RUN apk update && \
  apk add --no-cache \
  bash \
  openssl-dev

WORKDIR /opt/app

COPY --from=builder /opt/release .

CMD ["/opt/app/bin/revista_unified", "start"]
