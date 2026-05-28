# Storage Setup Project v1
This project focuses on creating a partition that uses 100% of the drive space.

## Purpose
The purpose of this project is to automate the creation of partition. It is important for a system administrator to know this because in a government environment, certain directories must be on a separate partition per STIG requirements.

## Requirements
- Be sure to have administrative access and be in an administrative environment using sudo -i
- Need to have an existing hard drive already attached.
- Red Hat Enterprise Linux 9 (or any RHEL-based Linux distribution)
- Bash shell
- Standard Linux utilities: parted, blkid, chown, chmod, echo, systemctl, mount

## How to Run
This script has something called positional arguments.
You can run the script by stating the script's name and adding your positional arguments. The positional arguments are variables that you have to input based on your needs.

### Example of How to Run
1.script name   2.positional argument 1 (disk)   3.positional argument 2 (mount_point)   4.positional argument 3 (group)   5.positional argument 4 (filesystem)
1.storage_setup_v1.sh	2./dev/sdb	3./mnt/test	4.developers	5.xfs

### Final Syntax
storage_setup_v1.sh /dev/sdb /mnt/test developers xfs

## Output
```
[rengoku@server ~]$ sudo -i
[root@server ~]# /home/rengoku/bin/storage_setup_v1.sh /dev/sdc /mnt/test developers xfs
meta-data=/dev/sdc1              isize=512    agcount=4, agsize=655296 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=1 inobtcount=1 nrext64=0
data     =                       bsize=4096   blocks=2621184, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=16384, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
mount: (hint) your fstab has been modified, but systemd still uses
       the old version; use 'systemctl daemon-reload' to reload.
The new partition has been created.
[root@server ~]# lsblk
NAME          MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda             8:0    0   20G  0 disk
├─sda1          8:1    0    1G  0 part /boot
└─sda2          8:2    0   19G  0 part
  ├─rhel-root 253:0    0   17G  0 lvm  /
  └─rhel-swap 253:1    0    2G  0 lvm  [SWAP]
sdb             8:16   0   10G  0 disk
└─sdb1          8:17   0   10G  0 part /mnt/devteam
sdc             8:32   0   10G  0 disk
└─sdc1          8:33   0   10G  0 part /mnt/test
sr0            11:0    1 1024M  0 rom
[root@server ~]# tail -1 /etc/fstab
UUID=79a9470a-3b4b-4382-9978-8c8848221258 /mnt/test xfs defaults 0 0
[root@server ~]#
```

## Future Improvements
The issue with this script now is that it adds an entry to /etc/fstab every time the script is run. Future improvements will be restructuring the script to use an if statement so that it will prevent the script from adding multiple entries with the same partition and mountpoint.
