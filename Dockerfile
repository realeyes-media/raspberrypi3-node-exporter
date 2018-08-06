FROM resin/raspberrypi3-debian:stretch
ENV NODEEXPORTER_VERSION=0.16.0

RUN [ "cross-build-start" ]

# Install Binary from Github Releases
RUN apt-get update && apt-get install -y wget
WORKDIR /build
RUN wget https://github.com/prometheus/node_exporter/releases/download/v${NODEEXPORTER_VERSION}/node_exporter-${NODEEXPORTER_VERSION}.linux-armv7.tar.gz
RUN tar -xvf node_exporter-${NODEEXPORTER_VERSION}.linux-armv7.tar.gz -C /build --strip-components=1 && cp /build/node_exporter /usr/local/bin

# Cleanup the mess from above
RUN rm -rf /build
WORKDIR /app

RUN [ "cross-build-end" ]

EXPOSE 9100
CMD node_exporter
