#!/bin/bash

mkdir -p ~/sysadmin/reports
{
        echo "=================================================="
        echo "SYSTEM REPORT: $(date)"
        echo "=================================================="
        echo ""
        echo "HOSTNAME: $(hostname)"
        echo ""
        echo "CURRENT LOGGED IN USER: $(whoami)"
        echo ""
        echo "KERNEL VERSION: $(uname -r)"
        echo ""
        echo "OS RELEASE: $(cat /etc/redhat-release)"
        echo ""
        echo "CPU MODEL:$(grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2)"
        echo ""
        echo "MEMORY USAGE:"
        echo "$(free -h)"
        echo ""
        echo "DISK USAGE:"
        echo "$(df -h)"
        echo ""
        echo "IP ADDRESS:"
        echo "$(hostname -I)"
        echo ""
        echo "SYSTEM UPTIME: $(uptime)"
        echo ""
        echo "SYSTEM REPORT COMPLETE!"
} > ~/sysadmin/reports/system_report_$(date +%Y-%m-%d_%H-%M-%S).txt
find ~/sysadmin/reports -name "system_report_*.txt" -mtime +7 -delete
