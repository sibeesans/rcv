#!/bin/bash
# My Telegram : https://t.me/RocknetStore
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
IZIN=$(curl -sS https://raw.githubusercontent.com/Rocknet Store/ipvps/main/ip | awk '{print $4}' | grep $MYIP )
if [[ $MYIP = $IZIN ]]; then
echo -e "${NC}${GREEN}Permission Accepted...${NC}"
else
echo -e "${NC}${RED}Permission Denied!${NC}";
echo -e "${NC}${LIGHT}Please Contact Admin!!"
rm -f certv2ray.sh
exit 0
fi                                                                                                                                                     clear
clear

read -rp "Domain/Host : " -e domain
echo $domain > /etc/xray/domain
cp /etc/xray/domain /root/domain
cp /etc/xray/domain /etc/v2ray/domain
echo start
systemctl stop v2ray
systemctl stop v2ray@none
systemctl stop xray
systemctl stop vmess-grpc
sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill
cd .acme.sh
bash acme.sh --set-default-ca --server letsencrypt
bash acme.sh --issue -d $domain --standalone -k ec-256 --force
bash acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
systemctl start vmess-grpc.service
systemctl start xray.service
systemctl start v2ray
systemctl start v2ray@none
systemctl start vmess-grpc
echo Done
sleep 1.5
clear
neofetch
