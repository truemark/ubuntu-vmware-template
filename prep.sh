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
	cat /dev/null > /var/log/syslog
fi

# Clear out ssh keys and files
rm -f /etc/ssh/ssh_host_*
rm -rf /root/.ssh
rm -rf /home/user/.ssh

# Setup re-generation of host keys
if ! grep -q "ssh-keygen" /etc/rc.local; then
sed -i '/exit 0/d' /etc/rc.local
cat >> /etc/rc.local <<-EOF
if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
        ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
fi
if [ ! -f /etc/ssh/ssh_host_dsa_key ]; then
        ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
fi
exit 0
EOF
fi

# Clean apt
apt-get clean

# Clear history
cat /dev/null > /root/.bash_history
cat /dev/null > /home/user/.bash_history
history -w
history -c

shutdown -h now
