#!/bin/bash
WAN="enp0s3"
LAN="enp0s8"

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT

iptables -A OUTPUT -o $WAN -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -o $WAN -p tcp --dport 443 -j ACCEPT

iptables -A FORWARD -i $LAN -o $WAN -p tcp --dport 443 -j ACCEPT
iptables -A FORWARD -i $LAN -o $WAN -p udp --dport 53 -j ACCEPT

iptables -A INPUT -i $LAN -s 192.168.100.10 -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -i $LAN -s 192.168.100.10 -p tcp --dport 61208 -j ACCEPT

iptables -A INPUT -i $LAN -s 192.168.100.11 -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -i $LAN -s 192.168.100.11 -p tcp --dport 21 -j ACCEPT
iptables -A INPUT -i $LAN -s 192.168.100.11 -p tcp --dport 20 -j ACCEPT

iptables -A INPUT -p icmp -j DROP
iptables -A OUTPUT -p icmp -j DROP

iptables -t nat -A POSTROUTING -o $WAN -j MASQUERADE
