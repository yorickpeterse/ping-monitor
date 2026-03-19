FROM alpine:3

RUN apk add --update --quiet fish
ADD monitor.fish /monitor.fish
ENTRYPOINT ["/usr/bin/fish", "monitor.fish"]
