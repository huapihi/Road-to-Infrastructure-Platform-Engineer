#!/bin/bash

# This script generates a user report and creates a copy of the report in the ~/sysadmin/reports directory.

# This command creates the ~/sysadmin/reports directory if it is not already created
mkdir -p ~/sysadmin/reports

(
	# Script header
	echo "============================================================"
	echo "User Audit for $(date)"
	echo "============================================================"
	echo ""
	# This command list all users that have a valid login shell
	echo "Users with valid login shell:"
	user_list=$(grep -E "bin/bash$|bin/zsh$|bin/sh$" /etc/passwd | cut -d':' -f1)
	echo "$user_list"
	echo ""
	# This for loop conditional statement will list all users that have never logged in and those who have logged in
	echo "Users who have never logged in:"
	for user in $user_list; do
		if lastlog -u $user | grep -qi "never logged in"; then
			echo "$user have never logged in."
		else
			echo "$user have logged in before."
		fi
	done
	echo ""
	# This for loop conditional statement will list users that does not have their password set and those who have set their password
	echo "Password expiration status:"
	for pass in $user_list; do
		if sudo chage -l $pass | grep -i "password expires" | grep -qi "never"; then
			echo "Password expiration is not set for $pass"
		else
			echo "Password expiration has been set for $pass"
		fi
	done
	echo ""
	# This command will list all users that are in the wheel group
	echo "Users that have sudo privileges:"
	cat /etc/group | grep wheel | cut -d":" -f4 | tr "," "\n"
	echo ""
	# This command list all users that are added to the /etc/sudoers.d directory
	echo "Users that are in the /etc/sudoers.d directory:"
	sudo ls -l /etc/sudoers.d | awk 'NR>1 {print $9}'
) > ~/sysadmin/reports/user_audit_$(date +%Y-%m-%d).txt
echo "User audit report has successfully generated. Please see the report in the ~/sysadmin/reports directory."
find ~/sysadmin/reports -name "user_audit_*" -mtime +7 -delete