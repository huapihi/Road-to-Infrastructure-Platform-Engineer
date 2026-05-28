#!/bin/bash

disk=$1
mount_point=$2
group=$3
filesystem=$4

# This command creates a partition table
parted -s $disk mklabel msdos

# This command creates a primary partition and use all of the device space
parted -s $disk mkpart primary $filesystem 1MiB 100%

# This command creates the filesystem for the partition
mkfs.$filesystem ${disk}1

# This command creates the mountpoint
mkdir -p $mount_point

UUID=$(blkid -s UUID -o value ${disk}1)

# This command will add the entries to /etc/fstab
echo "UUID=$UUID $mount_point $filesystem defaults 0 0" >> /etc/fstab

# This command will bind the partition to the mountpoint
mount -a

# This command reloads systemd after the file has been modified
systemctl daemon-reload

# This command changes the ownership of the directory for the mountpoint
chown :$group $mount_point

# This command changes the permission of the directory so that
# group will have rwx permission while others have no permissions
chmod 770 $mount_point

echo "The new partition has been created."
