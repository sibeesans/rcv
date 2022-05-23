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
# Getting
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
########################
MYIP=$(curl -sS ipv4.icanhazip.com)
echo "Checking VPS"                                                                                                               
IZIN=$(curl -sS https://raw.githubusercontent.com/Rocknet Store/ipvps/main/ip | awk '{print $4}' | grep $MYIP )                       
if [[ $MYIP = $IZIN ]]; then                                                                                                      
echo -e "${NC}${GREEN}Permission Accepted...${NC}"                                                                                
else                                                                                                                              
echo -e "${NC}${RED}Permission Denied!${NC}";                                                                                     
echo -e "${NC}${LIGHT}Please Contact Admin!!"                                                                                     
rm -f changeport.sh                                                                                                                    
exit 0                                                                                                                            
fi                                                                                                                                                                                                                                                  
clear
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"                 
echo -e "${RED}          • PORT CHANGER •          ${NC}"               
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e ""
echo -e "[•1] Change Port OpenVPN"
echo -e "[•2] Change Port Wireguard"
echo -e "[•3] Change Port Vmess"
echo -e "[•4] Change Port VLess"
echo -e "[•5] Change Port Trojan"
echo -e "[•6] Change Port Squid"
echo -e "[•7] Change Port XRay VMess"
echo -e "[•8] Change Port XRay VLess"
echo -e "[•9] Change Port XRay Trojan"
echo -e "[10] Change Port XRay XTLS"
echo -e "[11] Change Port Xray GRPC"
echo -e "[12] Change Port Trojan-go"
echo -e "[13] Change Port Trojan GRPC"
echo -e "[14] Change Port Trojan XTLS"
echo -e ""
echo -e "[${RED}•x${NC}] ${RED}Exit${NC}"
echo -e ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
read -p "Select From Options [ 1-12 ] : " port
case $port in
1)
portovpn
;;
2)
portwg
;;
3)
port-vmess
;;
4)
port-vless
;;
5)
port-trojan
;;
6)
portsquid
;;
7)
port-xws
;;
8)
port-xvl 
;;
9)
port-xtr 
;;
10)
port-xtls 
;;
11)
port-grpc
;;
12)
port-trojan-go
;;
13)
port-trgrpc
;;
14)
port-trxtls
;;
x)
exit
;;
*)
echo "Please enter an correct number"
changeport
;;
esac
