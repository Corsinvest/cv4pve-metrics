# cv4pve-metrics

[![license](https://img.shields.io/github/license/corsinvest/cv4pve-metrics.svg)](https://github.com/Corsinvest/cv4pve-metrics/blob/master/LICENSE.md)

## Copyright and License

Copyright: Corsinvest Srl
For licensing details please visit [LICENSE.md](https://github.com/Corsinvest/cv4pve-metrics/blob/master/LICENSE.md)

## Commercial Support

This software is part of a suite of tools called cv4pve-tools. If you want commercial support, visit the [site](https://www.cv4pve-tools.com)

## Introduction

These instructions are for configuring telegraf inside a Proxmox VE node.
Copy file configuration in specific folder.

Connect to node Proxmox VE

### Telegraf

Download and install [telegraf](https://portal.influxdata.com/downloads/)

The default configuration file is located in /etc/telegraf/telegraf.conf. Replace with this [file](./etc/telegraf/telegraf.conf).

Change sections:

```ini
[[outputs.influxdb]]
    urls = ["http://<SERVER InfluxDb>:8086"]  #IP/Hostname InfluxDB server
    database = "telegraf_proxmox"             #not necessary
```

### Install and configure IPMI tools

Install

```sh
apt-get install ipmitool
```

Change permission **telegraf** user to read **IPMI** information
Create file /etc/udev/rules.d/52-telegraf-ipmi.rules with content:

```txt
KERNEL=="ipmi*", MODE="660", GROUP="telegraf"
```

or copy this [file](./etc/udev/rules.d/52-telegraf-ipmi.rules) in /etc/udev/rules.d/52-telegraf-ipmi.rules

Reboot is required for apply change. If you want apply immediately change use this command:

```sh
chown :telegraf /dev/ipmi*
chmod g+rw /dev/ipmi*
```

### hddtemp

Install

```sh
apt-get install hddtemp
```

Enabled daemon in /etc/default/hddtemp or copy this [file](./etc/default/hddtemp) in /etc/default/hddtemp

Restart service

```sh
service hddtemp restart
```

### lm-sensors

Install

```sh
apt-get install lm-sensors
```

### Syslog integration

Integration with syslog use listener in telegraf.
Copy [file](./etc/rsyslog.d/telegraf.conf) in host /etc/rsyslog.d/telegraf.conf.

Restart service rsyslog

```sh
service rsyslog restart
```

### End configuration

Restart telegraf service

```sh
service telegraf restart
```
