!/bin/bash
#yum install java-1.8.0-openjdk
java -version
groupadd tomcat
useradd -g tomcat -d /opt/tomcat -s /bin/nologin tomcat
wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.32/bin/apache-tomcat-8.5.32.tar.gz
tar -zxvf apache-tomcat*tar.gz
mv apache-tomcat-8.5.32/* /opt/tomcat/
chown -R tomcat:tomcat /opt/tomcat/
firewall-cmd --permanent --add-port=8080/tcp
firewall-cmd --reload
firewall-cmd --list-port
chmod +x /opt/tomcat/bin/startup.sh
chmod +x /opt/tomcat/bin/shutdown.sh
sh /opt/tomcat/bin/startup.sh
sh /opt/tomcat/bin/shutdown.sh
sh /opt/tomcat/bin/startup.sh
