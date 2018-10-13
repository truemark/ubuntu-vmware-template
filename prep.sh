#!/bin/bash

# Clear out logs
service rsyslog stop
if [ -f /var/log/auth.log ]; then
	cat /dev/null > /var/log/auth.log
fi
if [ -f /var/log/wtmp ]; then
	cat /dev/null > /var/log/wtmp
fi
if [ -f /var/log/lastlog ]; then
	cat /dev/null > /var/log/lastlog
fi
if [ -f /var/log/syslog ]; then
	car /dev/null > /var/log/syslog
fi

# Clear out ssh keys and files
rm -f /etc/ssh/ssh_host_*
rm -rf /root/.ssh
rm -rf /home/user/.ssh

# Clean apt
apt-get clean

# Clear history
cat /dev/null > /root/.bash_history
cat /dev/null > /home/user/.bash_history
history -w
history -c

shutdown -h now
