FROM rust:1.57.0-slim-buster AS base

RUN apt update -y --no-install-recommends \
  && apt install -y --no-install-recommends wget xz-utils

# binstall does not produce a binary
ARG CARGO_WATCH_VERSION=cargo-watch-v8.1.2-x86_64-unknown-linux-gnu
RUN wget \
  https://github.com/watchexec/cargo-watch/releases/download/v8.1.2/${CARGO_WATCH_VERSION}.tar.xz \
  -O /tmp/${CARGO_WATCH_VERSION}.tar.xz \
  && tar -xf /tmp/${CARGO_WATCH_VERSION}.tar.xz -C /tmp \
  && mv /tmp/${CARGO_WATCH_VERSION}/cargo-watch /usr/local/bin/cargo-watch

RUN useradd app 
USER app
WORKDIR /app

COPY --chown=app ./ /app

CMD ["cargo", "run"]
