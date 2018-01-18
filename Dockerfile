FROM elixir:1.6.0-alpine

RUN apk update && apk add inotify-tools

RUN mix local.hex --force
RUN mix local.rebar --force

LABEL vendor=Space\ Scotch\ dot\ com \
      com.spacescotch.version="0.2"

CMD ["bin/ash"]
