#!/bin/bash
yum install java-1.8.0-openjdk
java -version
groupadd tomcat
useradd -g tomcat -d /opt/tomcat -s /bin/nologin tomcat
wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.32/bin/apache-tomcat-8.5.32.tar.gz
tar -zxvf apache-tomcat*tar.gz
mv apache-tomcat-8.5.32/* /opt/tomcat/
chown -R tomcat:tomcat /opt/tomcat/
chmod +x /opt/tomcat/bin/startup.sh
chmod +x /opt/tomcat/bin/shutdown.sh
sh /opt/tomcat/bin/startup.sh
sh /opt/tomcat/bin/shutdown.sh
sh /opt/tomcat/bin/startup.sh
netstat -an|grep 8080
#yum install -y iptables-services
#systemctl enable iptables
#iptables -I INPUT 1 -p tcp --dport 8080 -j ACCEPT
#iptables -I INPUT 1 -p tcp --dport 80 -j ACCEPT
#iptables -A PREROUTING -t nat -1 eth0 -p tcp --dport 80 -j REDIREDT --to-port 8080\n
#iptables-save > /etc/sysconfig/iptables\n

yum install -y firewalld
systemctl enable firewalld
systemctl start firewalld
firewall-cmd --permanent --add-port=8080/tcp
firewall-cmd --reload
firewall-cmd --list-port
firewall-cmd --permanent --add-forward-port=port=80:proto=tcp:toport=8080
firewall-cmd --permanent --remove-forward-port=port=80:proto=tcp:toport=8080

vi server.xml file 
vi tomcat.user file 
vi "context.xml" under webapps manager & host-manager

<!--  
<Context antiResourceLocking="false" privileged="true" >
  <Valve className="org.apache.catalina.valves.RemoteAddrValve" 
-->
