grafana Installation:
https://grafana.com/grafana/download?platform=linux
http://docs.grafana.org/installation/rpm/

wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-5.2.4-1.x86_64.rpm 
sudo yum install grafana-5.2.4-1.x86_64.rpm 
OR
yum install https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-5.2.4-1.x86_64.rpm -y 

systemctl daemon-reload
systemctl enable grafana-server.service
systemctl start grafana-server.service
