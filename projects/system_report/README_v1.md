# System Check Project v1
This project contains a script that runs various commands to view the system check results.

## Purpose
This script is designed for Linux System Administrators to quickly generate a snapshot of key system information and save it as a report.

## Requirements
- Red Hat Enterprise Linux 9 (or any RHEL-based Linux distribution)
- Bash shell
- Standard Linux utilities: uname, hostname, whoami, cat, grep, df, free, uptime, echo, head, date, cut

## How to Run
1. Create a bin directory under your user home directory.
2. Add/create the script in the bin directory.
3. Change the permission of the script so that it has executable permissions
4. Test the script by running the script: system_report.sh
5. View the generated report
	EX: cat ~/sysadmin/reports/system_report.txt

## Output
```
==================================================
SYSTEM REPORT: Thu May 21 10:57:59 PM EDT 2026
==================================================

HOSTNAME: (your~hostname)

CURRENT LOGGED IN USER: (your~username)

KERNEL VERSION: 5.14.0-611.5.1.el9_7.x86_64

OS RELEASE: Red Hat Enterprise Linux release 9.7 (Plow)

CPU MODEL: 13th Gen Intel(R) Core(TM) i7-1355U

MEMORY USAGE:
               total        used        free      shared  buff/cache   available
Mem:           3.6Gi       835Mi       2.3Gi        15Mi       765Mi       2.8Gi
Swap:          2.0Gi          0B       2.0Gi

DISK USAGE:
Filesystem             Size  Used Avail Use% Mounted on
devtmpfs               4.0M     0  4.0M   0% /dev
tmpfs                  1.8G     0  1.8G   0% /dev/shm
tmpfs                  732M  9.2M  722M   2% /run
/dev/mapper/rhel-root   17G  5.3G   12G  32% /
/dev/sda1              960M  375M  586M  40% /boot
tmpfs                  366M   52K  366M   1% /run/user/42
tmpfs                  366M   36K  366M   1% /run/user/1000

IP ADDRESS:
x.x.x.x

SYSTEM UPTIME:  22:58:00 up  1:32,  1 user,  load average: 0.08, 0.02, 0.01

SYSTEM REPORT COMPLETE!
```

## Future Improvements
The issue with this script now is that it overwrites the old report instead of archiving it. Future update adds the ability to archive the system_report_v1.txt without overwriting the previous report. The reports will be timestamped and auto-cleaned after 7 days, and the cron job that will be running daily at 0600.
