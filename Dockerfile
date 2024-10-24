FROM golang:1.21-alpine as builder
RUN apk update && apk add git bash build-base \
  && rm -rf /var/cache/apk/*
WORKDIR /github.com/simagix/hatchet
COPY . . 
RUN ./build.sh
FROM alpine
LABEL Ken Chen <ken.chen@simagix.com>
RUN addgroup -S simagix && adduser -S simagix -G simagix
USER simagix
WORKDIR /home/simagix
COPY --from=builder /github.com/simagix/hatchet/dist/hatchet /hatchet
CMD ["/hatchet", "--version"]
