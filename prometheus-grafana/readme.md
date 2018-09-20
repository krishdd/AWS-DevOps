# Prometheus Installation
*#* Prometheus official github repo
https://github.com/prometheus/prometheus/releases/
## download packages
```sh
yum install wget elinks git -y
wget https://github.com/prometheus/prometheus/releases/download/v2.4.1/prometheus-2.4.1.linux-amd64.tar.gz
```
```sh
tar -xzvf  prometheus-2.4.1.linux-amd64.tar.gz
cd prometheus-${PROMETHEUS_VERSION}.linux-amd64/
```
## If you just want to start prometheus as root execute below else create user
```sh
./prometheus --config.file=prometheus.yml
```
## create user
```sh
useradd --no-create-home --shell /bin/false prometheus
```
## create directories
```sh
mkdir -p /etc/prometheus
mkdir -p /var/lib/prometheus
```
## set ownership
```sh
chown prometheus:prometheus /etc/prometheus
chown prometheus:prometheus /var/lib/prometheus
```
## copy binaries
```sh
cp prometheus /usr/local/bin/
cp promtool /usr/local/bin/
chown prometheus:prometheus /usr/local/bin/prometheus
chown prometheus:prometheus /usr/local/bin/promtool
```
## copy config
```sh
cp -r consoles /etc/prometheus
cp -r console_libraries /etc/prometheus
cp prometheus.yml /etc/prometheus/prometheus.yml

chown -R prometheus:prometheus /etc/prometheus/consoles
chown -R prometheus:prometheus /etc/prometheus/console_libraries
```
## setup systemd
```sh
echo '[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/prometheus.service
```
## start prometheus process
```sh
systemctl daemon-reload
systemctl enable prometheus
systemctl start prometheus
```

