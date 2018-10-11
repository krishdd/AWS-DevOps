## ec2-instance - lost pem key recovery: by using "user data"

###### 1. Create a new key-pair or Use any of your existing key-pair
###### 2. get the working key pair

```sh
cat /home/ec2-user/.ssh/authorized_keys
```
###### 3. update the key
- stop ec2-instance.
- add below script in user data field.
(update your key details in the script after echo -e between quotes)
- start ec2-instance.
- loginto instance using updated key pair.

```sh 
Content-Type: multipart/mixed; boundary="//"
MIME-Version: 1.0

--//
Content-Type: text/cloud-config; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cloud-config.txt"

#cloud-config
cloud_final_modules:
- [scripts-user, always]

--//
Content-Type: text/x-shellscript; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="userdata.txt"
#!/bin/bash
/bin/echo -e "ssh-rsa KEY KEY KEY KEY KEY KEY KEY KEY KEY KEY KEY" >> /home/ec2-user/.ssh/authorized_keys
--//
```