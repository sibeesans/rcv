#!/bin/bash
# Color Validation
LIGHT='\033[0;37m'
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0;37m'
clear 
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${PURPLE}          • SYSTEM MENU •          ${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e ""
echo -e " [${CYAN}•1${NC}] Add Domain${NC} "
echo -e " [${CYAN}•2${NC}] Change Port All Account${NC} "
echo -e " [${CYAN}•3${NC}] Set Auto-Backup Data VPS${NC} "
echo -e " [${CYAN}•4${NC}] Backup Data VPS${NC} "
echo -e " [${CYAN}•5${NC}] VPS Backup Info${NC} "
echo -e " [${CYAN}•6${NC}] Restore Data VPS${NC} "
echo -e " [${CYAN}•7${NC}] Webmin Menu${NC} "
echo -e " [${CYAN}•8${NC}] Limit Bandwith Speed Server${NC} "
echo -e " [${CYAN}•9${NC}] Check Usage of Ram${NC} "
echo -e " [${CYAN}10${NC}] Speedtest VPS${NC} "
echo -e " [${CYAN}11${NC}] About Script${NC} "
echo -e " [${CYAN}12${NC}] Reboot VPS${NC} "
echo -e " [${CYAN}13${NC}] Clear Log${NC} "
echo -e " [${CYAN}14${NC}] Restart All Service${NC} "
echo -e " [${CYAN}15${NC}] Certv2ray${NC} "
echo -e " [${CYAN}16${NC}] Cek Bandwith${NC} "
echo -e " [${CYAN}17${NC}] Reset Server${NC} "
echo -e " [${CYAN}18${NC}] Kernel Update${NC} "
echo -e " [${CYAN}19${NC}] Set Auto Reboot${NC} "
echo -e " [${CYAN}20${NC}] Bbr${NC} "
echo -e ""
echo -e ""[${RED}12${NC}] ${RED}BACK TO MENU${NC}"
echo -e   ""
echo -e   "Press x or [ Ctrl+C ] • To-Exit"
echo -e   ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e ""
read -p " Select menu : " opt
echo -e ""
case $opt in
1) clear ; addhost ; exit ;;
2) clear ; changeport ; exit ;;
3) clear ; backup ; exit ;; #set.br
4) clear ; backup ; exit ;; #set.br
5) clear ; backup-info ; exit ;; #set.br
6) clear ; restore ; exit ;; #set.br
7) clear ; wbmn ; exit ;;
8) clear ; limitspeed ; exit ;; #set.br
9) clear ; ram ; exit ;;
10) clear ; speedtest ; exit ;;
11) clear ; about ; exit ;;
12) clear ; reboot ; exit ;;
13) clear ; clearlog ; exit ;;
14) clear ; restart ; exit ;;
15) clear ; certv2ray ; exit ;; #certv2ray
16) clear ; menu-bw ; exit ;;
17) clear ; resett ; exit ;;
18) clear ; kernel-updt ; exit ;;
19) clear ; auto-reboot ; exit ;;
20) clear ; bbr ; exit ;;
0) clear ; menu ; exit ;;
x) exit ;;
*) echo -e "" ; echo "Boh salah tekan, Sayang kedak Babi" ; sleep 1 ; m-system ;;
esac
