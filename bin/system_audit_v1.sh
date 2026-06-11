#!/bin/bash

# The purpose of this script is to run a system audit that will create an audit log in the ~/sysadmin/reports/ directory

# This command creates the ~/sysadmin/reports directory if it is not already created
mkdir -p ~/sysadmin/reports/
services="sshd chronyd firewalld"

(
	echo "======================================================"
	echo "System Audit for $(date)"
	echo "======================================================"
	echo ""
	# This for loop will show if the services listed are active or inactive
	echo "The following services are running or stopped:"
	for service in $services; do
		if systemctl is-active -q $service; then 
			echo "$service is running"
		else
			echo "$service is stopped"
		fi
	done
	echo ""
	# This conditional statement will show whether the services are running or stopped
	echo "Status of SELinux:"
	if getenforce | grep -q "Enforcing"; then
		echo "SELinux status is Enforcing"
	else
		echo "SELinux status is Permissive"
	fi	
	echo ""
	# This command will filter out users that have UUID above 1000 and less than 65534
	users=$(cat /etc/passwd | awk -F: '$3 > 1000 && $3 < 65534 {print $1}')
	echo "Users with UID above 1000:"
	echo "$users"
	echo ""
	echo "The following ports are open:"
	ss -tuln
	echo ""
	# This if then statement will send alert if disk usage goes above 80%
	echo "Current disk usage:"
	df -h | awk 'NR>1 {gsub(/%/,"",$5); if ($5+0 > 80) print "CRITICAL: "$6" has "$5"%"; else print "OK: "$6" has "$5"%"}'
) > ~/sysadmin/reports/audit_report_$(date +%Y-%m-%d).txt
echo "System audit report complete! Please view the report in the ~/sysadmin/reports directory."	
find ~/sysadmin/reports -name audit_report_*.txt -mtime +7 -delete
