# System Audit v1
This project runs a system audit script that will create an audit log in the ~/sysadmin/reports/ directory.

## Purpose
The purpose of this project is to generate a log for auditors to view regarding services that are stopped/running, open ports, SELinux is in Enforcing/Permissive mode, and creating an alert based on disk usage. It is important for a system administrator to know how to create and run this script so that it will automatically generate the report rather than thinking about it while focus on other tasks.

## Requirements
- Be sure to have administrative access and be in an administrative environment using sudo -i
- Red Hat Enterprise Linux 9 (or any RHEL-based Linux distribution)
- Bash shell
- Standard Linux utilities: getenforce, echo, df, awk, find, systemctl

## How to Run
1. Create a bin directory
2. Create the script
3. Change the script permission to execute
4. Type the script name in the terminal
5. Verify that the .txt file was created under the ~/sysadmin/reports directory

## Output
```
[rengoku@server ~]$ system_audit_v1.sh
System audit report complete! Please view the report in the ~/sysadmin/reports directory.
[rengoku@server ~]$ ls -l sysadmin/reports/
total 4
-rw-r--r--. 1 rengoku rengoku 2252 Jun 10 22:14 audit_report_2026-06-10.txt
[rengoku@server ~]$ cat sysadmin/reports/audit_report_2026-06-10.txt
**Sensitive Information**
```

## Future Improvements
Version 2:
- Add while loop for disk usage instead of using awk.
- Email report automatically after generation.

Version 3:
- Accept positional arguments so that services are not hardcoded.
- Add a threshold variable for disk usage so that you can change the 80% without editing the script.

Version 4:
- Check for failed login attempts from /var/log/secure.
- Check for users with empty passwords.
- Check for world-writeable files on the system.

Version 5:
- Deploy and run this script across multiple servers.
- Collect all reports to a central location.
