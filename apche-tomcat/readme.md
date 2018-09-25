# Installation and Configuraiton of Apache-Tomcat on AWS ec2-Instance

## Pre-req:
- a. java 1.8
- b. Set java home path 
### Install java1.8 JDK
```sh
yum install java-1.8.0-openjdk
```
### Set java_home path
```sh
java -version
alternatives --display java | head -2
vi /etc/profile
export JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.171-8.b10.el7_5.x86_64/"
echo $JAVE_HOME
```
### Create tomcat user, group and directories.
```sh
groupadd tomcat
useradd -g tomcat -d /opt/tomcat -s /bin/nologin tomcat
mkdir -p /opt/tomcat
```
### Download the required tomcat version to ec2-instance, in this case it is - "apache-tomcat-8.5.32"
```sh
yum install wget -y
wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.32/bin/apache-tomcat-8.5.32.tar.gz
```
### Unzip and untar the downloaded file. 
```sh
tar -zxvf apache-tomcat*tar.gz
mv apache-tomcat-8.5.32/* /opt/tomcat/
```
### set the ownership
```sh
chown -R tomcat:tomcat /opt/tomcat/
chmod +x /opt/tomcat/bin/startup.sh
chmod +x /opt/tomcat/bin/shutdown.sh
```
### move the contents of dir apache-tomcat-8.5.32 to newly created /opt/tomcat
```sh
mv apache-tomcat-8.5.32/* /opt/tomcat/
```
### If firewall is enabled, the ports configured for tomcat must be open and should allow traffic in AWS SG.
```sh
firewall-cmd --permanent --add-port=8080/tcp
firewall-cmd --reload
firewall-cmd --list-port
```

### Start/Stop tomcat services.
```sh
sh /opt/tomcat/bin/startup.sh
sh /opt/tomcat/bin/shutdown.sh
```
##### You can also create softlink for stop & srtat tomcat, so that you can execute from any location. 
```sh
echo $PATH
/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
ln -s /opt/tomcat/bin/startup.sh /usr/local/bin/tomcatup
ln -s /opt/tomcat/bin/shutdown.sh /usr/local/bin/tomcatdown
tomcatup - for starting tomcat 
tomcatdown - for stopping tomcat 
```
### Verify tomcat process running.
```sh
ps -ef|grep tomcat 
netstat -an|grep 8080
``` 
### NB: The default installation of tomcat will enable access GUI from local machine only. Since ec2-instance has been in this case..

### To connect remotely the following taks should be performed:
#### Create tomcat users,roles etc.,
```sh
<role rolename="manager-gui"/>
<role rolename="admin-gui"/>
<user username="admin" password="admin" roles="admin-gui,manager-gui"/>
```
### Modify configurations in "context.xml"(webapps manager & host-manager) to allow remote connection.
```sh
<!--
<Context antiResourceLocking="false" privileged="true" >
  <Valve className="org.apache.catalina.valves.RemoteAddrValve" 
-->
```
### Optionally the defult port of 8080 also can be changed in "server.xml"
```sh
connector port="8080"
```
### Restart tomcat services.
```sh
sh /opt/tomcat/bin/startup.sh  OR tomcatdown
sh /opt/tomcat/bin/shutdown.sh  OR tomcatup
```
### Log into GUI using url 
 for ex: http://<IP/FQDN>:8080


