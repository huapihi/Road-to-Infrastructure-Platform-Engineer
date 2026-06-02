# Storage Setup Project v2
This project follows up with storage_setup_v1.sh. The improvements made in this project were the addition of logical volume management (lvm).

## Purpose
The purpose of this project is to automate the creation of lvm. It is important for the system administrator to learn how to create lvm because in a production environment, storage must be expandable with minimal downtime.

## Requirements
- Be sure to have administrative access and be in an administrative environment using sudo -i
- Need to have an existing hard drive already attached.
- Red Hat Enterprise Linux 9 (or any RHEL-based Linux distribution)
- Bash shell
- Standard Linux utilities: parted, blkid, chown, chmod, echo, systemctl, mount
- LVM utilities: pvcreate, vgcreate, lvcreate

## How to Run
This script has something called positional arguments.
You can run the script by stating the script's name and adding your positional arguments. The positional arguments are variables that you have to input based on your needs.

### Example of How to Run
1.script name   2.positional argument 1 (disk)   3.positional argument 2 (vg_name)   4.positional argument 3 (lv_name)   5.positional argument 4 (size)   6.positional argument 5 (mount_point)   7.positional argument (group)

1.storage_setup_v2.sh   2.disk      3.vg_name     4.lv_name    5.size    6.mount_point    7.group

### Final Syntax
storage_setup_v2.sh /dev/sdc vg_data lv_data 5G /mnt/data management

## Output
```
[root@server ~]# /home/rengoku/bin/storage_setup_v2.sh /dev/sdc datavg datalv 5G /mnt/data management
  Physical volume "/dev/sdc1" successfully created.
  Volume group "datavg" successfully created
  Wiping xfs signature on /dev/datavg/datalv.
  Logical volume "datalv" created.
meta-data=/dev/mapper/datavg-datalv isize=512    agcount=4, agsize=327680 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=1 inobtcount=1 nrext64=0
data     =                       bsize=4096   blocks=1310720, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=16384, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
mount: (hint) your fstab has been modified, but systemd still uses
       the old version; use 'systemctl daemon-reload' to reload.
Logical volume /dev/mapper/datavg-datalv has been created
[root@server ~]# lsblk
NAME              MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda                 8:0    0   20G  0 disk
├─sda1              8:1    0    1G  0 part /boot
└─sda2              8:2    0   19G  0 part
  ├─rhel-root     253:0    0   17G  0 lvm  /
  └─rhel-swap     253:1    0    2G  0 lvm  [SWAP]
sdb                 8:16   0   10G  0 disk
└─sdb1              8:17   0   10G  0 part /mnt/devteam
sdc                 8:32   0   10G  0 disk
└─sdc1              8:33   0   10G  0 part
  └─datavg-datalv 253:2    0    5G  0 lvm  /mnt/data
sr0                11:0    1 1024M  0 rom
[root@server ~]#
```

## Future Improvements
Future improvements will consist of creating multiple partitions, extending logical volume, and have the filesystem as a variable instead of it being hardcoded.
