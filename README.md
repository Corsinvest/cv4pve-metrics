# cv4pve-metrics

[![License](https://img.shields.io/github/license/Corsinvest/cv4pve-metrics.svg)](LICENSE.md)

This solutions consists of more parts:

* **docker** Docker compose with InfluxDb, Telegraf, Kapacitor, Cronograf, Grafana
* **scripts-hook** Hook Script for send metrics to InfluxDB use protocol http (vzdump, cv4pve-autosnap)
* **telegraf-pve-node** Documentation for setting telegraf inside node Proxmox VE
* Dashboard Grafana:
  * [Proxmox VE Home](https://grafana.com/grafana/dashboards/11416)
  * [Proxmox VE Alert](https://grafana.com/grafana/dashboards/11418)

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
