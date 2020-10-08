# cv4pve-metrics

[![License](https://img.shields.io/github/license/Corsinvest/cv4pve-metrics.svg)](LICENSE.md)

This solutions consists of more parts (subdirectory src):

* **docker** Docker compose with InfluxDb, Telegraf, Kapacitor, Cronograf, Grafana
* **scripts-hook** Hook Script for send metrics to InfluxDB use protocol http (vzdump, cv4pve-autosnap)
* **telegraf-pve-node** Documentation for setting telegraf inside node Proxmox VE

Dashboards for Grafana:

* [Proxmox VE Home](https://grafana.com/grafana/dashboards/11416)
* [Proxmox VE Alert](https://grafana.com/grafana/dashboards/11418)
* [Proxmox VE cv4pve-autosnap](https://grafana.com/grafana/dashboards/13099)
* [Proxmox VE Backup VZDump](https://grafana.com/grafana/dashboards/12907)
* [Proxmox VE KVM](https://grafana.com/grafana/dashboards/12908)
* [Proxmox VE Network](https://grafana.com/grafana/dashboards/12909)
* [Proxmox VE Node](https://grafana.com/grafana/dashboards/12910)
* [Proxmox VE Node Detailed](https://grafana.com/grafana/dashboards/12911)
* [Proxmox VE Node IPMI](https://grafana.com/grafana/dashboards/12912)
* [Proxmox VE Sensors](https://grafana.com/grafana/dashboards/12913)
* [Proxmox VE Storage](https://grafana.com/grafana/dashboards/12914)
* [Proxmox VE Syslog](https://grafana.com/grafana/dashboards/12915)

For more dashboards or metrics in cloud visit https://www.cv4pve-tools.com and see plans support.

```text
    ______                _                      __
   / ____/___  __________(_)___ _   _____  _____/ /_
  / /   / __ \/ ___/ ___/ / __ \ | / / _ \/ ___/ __/
 / /___/ /_/ / /  (__  ) / / / / |/ /  __(__  ) /_
 \____/\____/_/  /____/_/_/ /_/|___/\___/____/\__/

Metrics for Proxmox VE                (Made in Italy)
```

## Copyright and License

Copyright: Corsinvest Srl
For licensing details please visit [LICENSE.md](LICENSE.md)

## Commercial Support

This software is part of a suite of tools called cv4pve-tools. If you want commercial support, visit the [site](https://www.cv4pve-tools.com)
