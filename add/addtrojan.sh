#!/bin/bash
# Trojanx
# ==================

# Color
RED="\e[1;31m"
GREEN="\e[0;32m"
NC="\e[0m"

# Validate Your IP Address
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
clear
uuid=$(cat /etc/trojan/uuid.txt)
source /var/lib/RocknetZ/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/v2ray/domain)
else                                                                      
domain=$IP                                                                
fi
tr=$(cat /etc/trojan/config.json | grep local_port | sed 's/local_//g' | sed 's/port//g' | sed 's/://g' | sed 's/,//g' | sed 's/"//g' | sed 's/   //g' | sed 's/  //g')
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
		read -rp "Password: " -e user
		user_EXISTS=$(grep -w $user /etc/trojan/akun.conf | wc -l)

		if [[ ${user_EXISTS} == '1' ]]; then
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			exit 1
		fi
	done
MYIP=$(wget -qO- ipinfo.io/ip);
domain=$(cat /etc/v2ray/domain)
read -p "Expired (days): " masaaktif
read -p "SNI (BUG)     : " sni
read -p "Subdomain (EXP : Rocknet Store.xyz. / Press Enter If Only Using Hosts) : " sub
dom=$sub$domain
sed -i '/"'""$uuid""'"$/a\,"'""$user""'"' /etc/trojan/config.json
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
echo -e "### $user $exp" >> /etc/trojan/akun.conf
systemctl restart trojan
trojanlink="trojan://${user}@${dom}:${tr}?sni=$sni#$user"
echo -e "================================="
echo -e "          V2RAY TROJAN          "
echo -e "================================="
echo -e "Remarks   : ${user}"
echo -e "IP/Host   : ${MYIP}"
echo -e "Domain    : ${domain}"
echo -e "Bug       : ${sni}"
echo -e "Subdomain : $dom"
echo -e "Port      : ${tr}"
echo -e "Key       : ${user}"
echo -e "================================="
echo -e "Link TR   : ${trojanlink}"
echo -e "================================="
echo -e "Created   : $hariini"
echo -e "Expired   : $exp"
echo -e "================================="
echo -e "Server By Rocknet Store"
