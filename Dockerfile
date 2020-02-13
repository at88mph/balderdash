FROM elixir:alpine

WORKDIR /usr/src/app

COPY ./ /usr/src/app

RUN apk --no-cache add nodejs npm inotify-tools

RUN mix local.hex --force \
    && mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phx_new.ez \
    && mix local.rebar --force \
    && cd assets \
    && npm install \
    && cd /usr/src/app

CMD ["mix", "phx.server"]
