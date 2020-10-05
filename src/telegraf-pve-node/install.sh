#!/bin/bash
#
# This file is part of the cv4pve-metrics https://github.com/Corsinvest/cv4pve-metrics,
#
# This source file is available under two different licenses:
# - GNU General Public License version 3 (GPLv3)
# - Corsinvest Enterprise License (CEL)
# Full copyright and license information is available in
# LICENSE.md which is distributed with this source code.
#
# Copyright (C) 2016 Corsinvest Srl	GPLv3 and CEL
#
# Save metrics for autosnap on database InfluxDB

# install telegraf
wget https://dl.influxdata.com/telegraf/releases/telegraf_1.15.2-1_amd64.deb
dpkg -i telegraf_1.15.2-1_amd64.deb
rm telegraf_1.15.2-1_amd64.deb

wget -O /etc/telegraf/telegraf.conf https://raw.githubusercontent.com/Corsinvest/cv4pve-metrics/master/src/telegraf-pve-node/etc/telegraf/telegraf.conf

# Install and configure IPMI tools
apt-get --assume-yes install ipmitool
wget -O /etc/udev/rules.d/52-telegraf-ipmi.rules https://raw.githubusercontent.com/Corsinvest/cv4pve-metrics/master/src/telegraf-pve-node/etc/udev/rules.d/52-telegraf-ipmi.rules

# Reboot is required for apply change. If you want apply immediately change use this command:
chown :telegraf /dev/ipmi*
chmod g+rw /dev/ipmi*

# hddtemp
apt-get --assume-yes install hddtemp
wget -O /etc/default/hddtemp https://raw.githubusercontent.com/Corsinvest/cv4pve-metrics/master/src/telegraf-pve-node/etc/default/hddtemp

service hddtemp restart

# lm-sensors
apt-get --assume-yes install lm-sensors

# Syslog integration
wget -O /etc/rsyslog.d/telegraf.conf https://raw.githubusercontent.com/Corsinvest/cv4pve-metrics/master/src/telegraf-pve-node/etc/rsyslog.d/telegraf.conf

service rsyslog restart

# Restart service telegraf
service telegraf restart
