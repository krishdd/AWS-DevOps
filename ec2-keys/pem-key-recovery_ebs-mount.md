# ec2-instance - lost pem key recovey: by replacing with working pem key-pair (ec2-user) of another ec2-instance

1. Create a new key-pair
or 
Use any of your existing key-pair

2. In aws console goto Instance details of which key is lost and note down instance-id, AMI, AZ, root device name and EBS-ID and alos better to notedown ElasticIP/PublicIP/Private detials aswell.

3. In same AZ, choose any other normal instance which has working key-pair OR launch a new temporary instance for key replace purpose. (here after we call it as recovery instance).

4. Stop the instance (lost-key instance) and detach the root EBS voulme and attach it to the Recovery instance.

5. Log into Recovery instance as ec2-user.

6. Use the lsblk command to determine if the volume is partitioned If yes, please mount the partition (/dev/xvdf1) instead of the raw device (/dev/xvdf)
```sh 
lsblk
```

7. create a temporary dir "lost-instance-vol"
```sh
 mkdir "lost-instance-vol"
```

8. mount the vol and verify properly mounted.
```sh
mount -o nouuid /dev/xvdf1 /lost-instance-vol
df -h /lost-instance-vol
ls -ld /lost-instance-vol
```
9. copy recovery instance authorized_keys to the newly mounted authorized_keys
- note down owner & permissions 
```sh
ls -l /lost-instance-vol/home/ec2-user/.ssh/authorized_keys
ls -l /home/ec2-user/.ssh/authorized_keys 
cp /home/ec2-user/.ssh/authorized_keys /lost-instance-vol/home/ec2-user/.ssh/authorized_keys
```
10. Verify the owner and permissions.
```sh
ls -l /lost-instance-vol/home/ec2-user/.ssh/authorized_keys
```
11. unmount the "lost-instance-vol"
```sh
umount /lost-instance-vol
df -h /lost-instance-vol
```
12. Detach the EBS volume from the recovery instance and attach it to the original instance
###### NOTE: While attching make sure the device name should be /dev/sda1 or /dev/xvda) otherwise ec2 instance will not come up.
13. Start the ec2-instance and login with new key-pair or working key-pair (based on the approach you have chosen).










 
 
