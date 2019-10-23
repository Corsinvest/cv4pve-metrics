docker run -p 3003:3003 -p 3004:8888 -p 8086:8086 -p 8089:8089/udp -v d:/datademo/influxdb:/var/lib/influxdb -v d:/datademo/grafana:/var/lib/grafana corsinvest/cv4pve-metrics:latest

#docker run -d --name cv4pve-metrics -p 3003:3003 -p 3004:8888 -p 8086:8086 -p 8089:8089/udp corsinvest/cv4pve-metrics:latest

#docker run -d --name cv4pve-metrics -p 3003:3003 -p 3004:8888 -p 8086:8086 -p 8089:8089/udp -v /var/docker/cv4pve-metrics/influxdb:/var/lib/influxdb -v /var/docker/cv4pve-metrics/grafana:/var/lib/grafana corsinvest/cv4pve-metrics:latest

#dotnet run -- --host 10.92.90.91 --username test@pam --password test