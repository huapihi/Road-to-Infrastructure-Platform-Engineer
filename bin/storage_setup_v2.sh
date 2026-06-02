#!/bin/bash

disk=$1
vg_name=$2
lv_name=$3
size=$4
mount_point=$5
group=$6

# This command lets you create the partition table
parted -s $disk mklabel msdos

# This command lets you partition the entire disk
parted -s $disk mkpart primary xfs 1MiB 100%

# This command changes the partition type to lvm
parted -s $disk set 1 lvm on

# This command initialize the partition as a physical volume
pvcreate ${disk}1

# This command creates a volume group
vgcreate $vg_name ${disk}1

# This command creates a logical volume
lvcreate -y -n $lv_name -L $size /dev/$vg_name

# This command formats the logical volume as XFS filesystem
mkfs.xfs -f /dev/mapper/$vg_name-$lv_name

# This command creates a mount point for the logical volume
mkdir -p $mount_point

# This command adds the UUID to /etc/fstab to make it persistent
UUID=$(blkid -s UUID -o value /dev/mapper/$vg_name-$lv_name)

# This if then statement will look to see if the entry already exists
# If the entry does not already exists, the script will add the entry to /etc/fstab
# If the entry already exists, the script will skip this step

if grep -q "$UUID" /etc/fstab; then
	echo "Entry already exists, exiting..."
else
	echo "UUID=$UUID $mount_point xfs defaults 0 0" >> /etc/fstab
fi

# This command checks to see if all mount points are mounted correctly
mount -a

# This command refreshes the /etc/fstab file after all edits
systemctl daemon-reload

# This command changes the ownership of the mount point
chown :$group $mount_point

# This command changes the permission of the mount point
chmod 770 $mount_point

# Completion message
echo "Logical volume /dev/mapper/$vg_name-$lv_name has been created"
