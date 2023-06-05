#!/bin/bash

apt update
apt install -y snmp snmpd

interfaces_file='/etc/network/interfaces'

ip=$(grep -Po "^\s*address \K[\d.]+(?=\/)" "$interfaces_file" | head -n 1)

echo "$ip"

sed -i "s/^agentaddress.*/agentaddress udp:${ip}:161/" /etc/snmp/snmpd.conf
sed -i 's/^rocommunity.*/rocommunity public-asr 10.22.1.200/' /etc/snmp/snmpd.conf

systemctl restart snmpd
