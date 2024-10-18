FROM elixir:1.15-slim

WORKDIR /app

# Optimize to cache dependencies
COPY mix.exs mix.lock ./

RUN mix local.hex --force && mix local.rebar --force
RUN mix deps.get

COPY . .

RUN mix escript.build

CMD ["./deploy_da_bomb"]
