# This file is part of the cv4pve-metrics https://github.com/Corsinvest/cv4pve-metrics,
#
# This source file is available under two different licenses:
# - GNU General Public License version 3 (GPLv3)
# - Corsinvest Enterprise License (CEL)
# Full copyright and license information is available in
# LICENSE.md which is distributed with this source code.
#
# Copyright (C) 2016 Corsinvest Srl	GPLv3 and CEL

FROM debian:stretch-slim
LABEL maintainer="Corsini Daniele <daniele.corsini@corsinvest.it>"

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

# Default versions
ENV INFLUXDB_VERSION=1.7.7
ENV CHRONOGRAF_VERSION=1.7.12
ENV GRAFANA_VERSION=6.4.1

# Grafana database type
ENV GF_DATABASE_TYPE=sqlite3
#ENV GF_PLUGIN_DIR=/grafana-plugins

# Fix bad proxy issue
COPY system/99fixbadproxy /etc/apt/apt.conf.d/99fixbadproxy

WORKDIR /root

# Clear previous sources
RUN rm /var/lib/apt/lists/* -vf \
    # Base dependencies
    && apt-get -y update \
    && apt-get -y dist-upgrade \
    && apt-get -y --force-yes install \
        apt-utils \
        ca-certificates \
        curl \
        git \
        htop \
        libfontconfig \
        nano \
        net-tools \
        supervisor \
        wget \
        jq \
        gnupg \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs \
    && mkdir -p /var/log/supervisor \
    && rm -rf .profile \
    # Install InfluxDB
    && wget https://dl.influxdata.com/influxdb/releases/influxdb_${INFLUXDB_VERSION}_amd64.deb \
    && dpkg -i influxdb_${INFLUXDB_VERSION}_amd64.deb && rm influxdb_${INFLUXDB_VERSION}_amd64.deb \
    # Install Chronograf
    && wget https://dl.influxdata.com/chronograf/releases/chronograf_${CHRONOGRAF_VERSION}_amd64.deb \
    && dpkg -i chronograf_${CHRONOGRAF_VERSION}_amd64.deb && rm chronograf_${CHRONOGRAF_VERSION}_amd64.deb \
    # Install Grafana
    && wget https://dl.grafana.com/oss/release/grafana_${GRAFANA_VERSION}_amd64.deb \
    && dpkg -i grafana_${GRAFANA_VERSION}_amd64.deb && rm grafana_${GRAFANA_VERSION}_amd64.deb \
    # Install all plugins grafana
#    && for plugin in $(curl -s https://grafana.net/api/plugins?orderBy=name | jq '.items[] | select(.internal=='false') | .slug' | tr -d '"'); do grafana-cli plugins install $plugin; done \
#    && for plugin in $(curl -s https://grafana.net/api/plugins?orderBy=name | jq '.items[] | select(.internal=='false') | .slug' | tr -d '"'); do grafana-cli --pluginsDir "${GF_PLUGIN_DIR}" plugins install $plugin; done \
    # Cleanup
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Configure Supervisord and base env
COPY supervisord/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY bash/profile .profile

# Configure InfluxDB
COPY influxdb/influxdb.conf /etc/influxdb/influxdb.conf
COPY influxdb/init.sh /etc/init.d/influxdb

# Configure Grafana
ADD grafana/provisioning /etc/grafana/provisioning
ADD grafana/dashboards /var/lib/grafana/dashboards
COPY grafana/grafana.ini /etc/grafana/grafana.ini

RUN chmod 0755 /etc/init.d/influxdb

COPY run.sh /run.sh
RUN ["chmod", "+x", "/run.sh"]
CMD ["/run.sh"]
