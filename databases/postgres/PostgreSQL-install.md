
# PostgreSQL Installation on RHEL ec2-instances

https://www.postgresql.org/download/linux/redhat/

##### Install Postgress
CentOS/RHEL-7 #rpm -Uvh https://yum.postgresql.org/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm
##### Install using yum 
```sh
yum install postgresql-server postgresql-contrib
postgresql-setup initdb
passwd postgres
systemctl start postgresql
systemctl enable postgresql
su - postgres -c psql
```


https://www.postgresql.org/download/linux/redhat/
Postgres version:9.6, RHEL64bit
```sh
# yum install https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-redhat96-9.6-3.noarch.rpm
```
- If No internet connectivity; then
```sh
yum install pgdg-redhat96-9.6-3.noarch.rpm -y
yum install postgresql96
yum install postgresql96-server
/usr/pgsql-9.6/bin/postgresql96-setup initdb
systemctl enable postgresql-9.6
systemctl start postgresql-9.6
```
##### Configuration - Based on requirement below files can be modified - IP/hostname, connections, memory, ports, logging etc.,
```sh
/var/lib/pgsql/9.6/data/pg_hba.conf
/var/lib/pgsql/9.6/data/postgresql.conf
```
2. Install by using rpm
```sh
rpm -Uvh <packages>
```

```sh
yum install postgresql-server postgresql-contrib
 Create a new PostgreSQL database cluster:
postgresql-setup initdb
 By default, PostgreSQL does not allow password authentication. We will change that by editing its host-based authentication (HBA) configuration.
cp -p /var/lib/pgsql/data/pg_hba.conf /var/lib/pgsql/data/pg_hba.conf.orig
sed -i 's/ident/md5/g' /var/lib/pgsql/data/pg_hba.conf
  
Then replace "ident" with "md5"
 host    all             all             127.0.0.1/32            md5
 host    all             all             ::1/128                 md5
 
 ```sh
 systemctl start postgresql
 systemctl enable postgresql
 systemctl restart postgresql
 ```
 sudo -i -u postgres 
 psql  (To get Postgres prompt and "\q" to exit)
 or su - postgres -c "psql"
 password postgres  (You may create password for user postgres for security purpose.)
 
 Ports: "5432"
 
 To create addiotonal users and roles and databases 
 sudo -u postgres createuser -s $(whoami); createdb $(whoami)

cd /var/lib/pgsql/9.6/data/
cp -p pg_hba.conf pg_hba.conf.kk
cp -p pg_hba.conf pg_hba.conf.orig
cp -p postgresql.conf postgresql.conf.kk
cp -p postgresql.conf postgresql.conf.orig

----------------------
below are very imp files to be modified inorder to connect db remotely either by cmd or GUI tols like pgadmin
pg_hba.conf= removei"ident" and replace with md5 like below..
# "local" is for Unix domain socket connections only
local   all             all                                     peer
# IPv4 local connections:
host    all             all             127.0.0.1/32            md5
# IPv6 local connections:
host    all             all             ::1/128                 md5
host    all             all             0.0.0.0/0               md5
host    all             all             ::0/0                   md5

posgresql.conf = uncomment and chnage values to specfic ip or * and resetat postgresql
listen_addresses = '*'                                                 
                                       # defaults to 'localhost'; use '*' for all
                                        # (change requires restart)
port = 5432   
listen_addresses = '*'  or specific IP      
--------------------

to connect remotely:
its good idea to create new user at db level and use it.
su - postgres
createuser -s dbadmin -P
it will ask for passwd so set the passwd aswell.. however u need to set the passwd again at psql prompt.
psql
alter user <userid> with password '<passwd>';
alter user postgres  with password 'demo@dba';

- then try to login remotely..
USE:
```sh
psql -h <host> -p <port> -u <database>
psql -h <host> -p <port> -U <username> -W <password> <databasename>
```
