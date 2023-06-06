wget https://repo.zabbix.com/zabbix/6.4/debian/pool/main/z/zabbix-release/zabbix-release_6.4-1+debian11_all.deb

dpkg -i zabbix-release_6.4-1+debian11_all.deb
apt update

apt install zabbix-agent

systemctl enable zabbix-agent
systemctl start zabbix-agent

file='/etc/zabbix/zabbix_agentd.conf'

sed -i "s/^Server=127.*/Server=10.21.1.50/" /etc/zabbix/zabbix_agentd.conf
sed -i 's/^# ListenPort.*/ListenPort=10050/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/^# ListenIP.*/ListenIP=0.0.0.0/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/^ServerActive.*/ServerActive=10.21.1.50/' /etc/zabbix/zabbix_agentd.conf

apt install -y ufw

ufw allow 10050

ufw reload

