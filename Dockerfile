FROM resin/raspberrypi3-debian:stretch as builder
ENV NODEEXPORTER_VERSION=0.16.0

RUN [ "cross-build-start" ]

# Install Binary from Github Releases
RUN apt-get update && apt-get install -y wget
WORKDIR /build
RUN wget https://github.com/prometheus/node_exporter/releases/download/v${NODEEXPORTER_VERSION}/node_exporter-${NODEEXPORTER_VERSION}.linux-armv7.tar.gz
RUN tar -xvf node_exporter-${NODEEXPORTER_VERSION}.linux-armv7.tar.gz -C /build --strip-components=1

FROM resin/raspberrypi3-alpine:3.8
COPY --from=builder /build/node_exporter /usr/local/bin

EXPOSE 9100
CMD node_exporter
