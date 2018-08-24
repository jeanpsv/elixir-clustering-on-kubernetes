FROM elixir:1.5.1

ENV DEBIAN_FRONTEND=nointeractive
ENV HOME=/opt/app TERM=xterm

RUN mix local.hex --force && mix local.rebar --force

WORKDIR /app

ENV MIX_ENV=prod
ENV REPLACE_OS_VARS=true

COPY mix.exs mix.lock ./
RUN mix deps.get --only prod
COPY config ./config
RUN mix deps.compile
COPY . .
RUN mix release --env=prod

ENTRYPOINT ["_build/prod/rel/elixir_clustering_on_kubernetes/bin/elixir_clustering_on_kubernetes"]
