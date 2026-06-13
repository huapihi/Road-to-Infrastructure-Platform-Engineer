# User Audit Project v1
This project generates a user audit report covering valid login shells, accounts that have never logged in, expired or unset passwords, and users with sudo privileges. A copy is saved to the ~/sysadmin/reports directory.

## Purpose
This script is designed for Linux System Administrators to quickly generate a report that allows auditors to audit users that are currently in the system.

## Requirements
- Red Hat Enterprise Linux 9 (or any RHEL-based Linux distribution)
- Bash shell
- Standard Linux utilities: date, grep, lastlog, tr, cut, echo, awk, find, ls, cat

## How to Run
1. Create a bin directory under your user home directory.
2. Add/create the script in the bin directory.
3. Change the permission of the script so that it has executable permissions
4. Test the script by running the script: user_audit_v1.sh
5. View the generated report
	EX: cat ~/sysadmin/reports/user_audit_2026-06-13.txt

## Output
```
============================================================
User Audit for Sat Jun 13 01:29:35 AM EDT 2026
============================================================

Users with valid login shell:
**List of users**

Users who have never logged in:
**User**  have never logged in.
**User** have logged in before.

Password expiration status:
Password expiration is not set for **User**
Password expiration has been set for **User**

Users that have sudo privileges:
**List of users**

Users that are in the /etc/sudoers.d directory:
**List of /etc/sudoers.d/ drop in files**
```

## Future Improvements
1. Accept shell list without it being hardcoded (creating a variable).
2. Flag account that have never logged in but DO have sudo access.
3. Cross-reference password expiration with password policy.
4. Check for accounts with UID 0 other than root.
5. Email the report after it has been generated.
6. Deploy script using Ansible automation to multiple servers.
