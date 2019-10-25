# This file is part of the cv4pve-metrics https://github.com/Corsinvest/cv4pve-metrics,
#
# This source file is available under two different licenses:
# - GNU General Public License version 3 (GPLv3)
# - Corsinvest Enterprise License (CEL)
# Full copyright and license information is available in
# LICENSE.md which is distributed with this source code.
#
# Copyright (C) 2016 Corsinvest Srl	GPLv3 and CEL

docker run -p 3003:3003 -p 3004:8888 -p 8086:8086 -p 8089:8089/udp -v d:/datademo/influxdb:/var/lib/influxdb -v d:/datademo/grafana:/var/lib/grafana corsinvest/cv4pve-metrics:latest

#docker run -d --name cv4pve-metrics -p 3003:3003 -p 3004:8888 -p 8086:8086 -p 8089:8089/udp corsinvest/cv4pve-metrics:latest

#docker run -d --name cv4pve-metrics -p 3003:3003 -p 3004:8888 -p 8086:8086 -p 8089:8089/udp -v /var/docker/cv4pve-metrics/influxdb:/var/lib/influxdb -v /var/docker/cv4pve-metrics/grafana:/var/lib/grafana corsinvest/cv4pve-metrics:latest

#dotnet run -- --host 10.92.90.91 --username test@pam --password test