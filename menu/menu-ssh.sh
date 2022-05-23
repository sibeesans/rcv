#!/bin/bash
#Menu
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0;37m'
bd='\e[1m'                                                                                                                                                                                        
#getting                                                                                                    
IP=$(wget -qO- ipinfo.io/ip);                                                                                       
echo "Checking VPS"                                                                                                 
clear                                                                                                               
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"                                                           
echo -e "${RED}          • MENU SSH •          ${NC}"                                                               
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"                                                           
echo -e""                                                                                                           
echo -e "[${CYAN}•1${NC}] $bd Create Account SSH & OpenVPN ${NC}"                                                   
echo -e "[${CYAN}•2${NC}] $bd Trial Account SSH & OpenVPN ${NC}"                                                    
echo -e "[${CYAN}•3${NC}] $bd Renew Account SSH & OpenVPN ${NC}"                                                    
echo -e "[${CYAN}•4${NC}] $bd Delete Account SSH & OpenVPN ${NC}"                                                   
echo -e "[${CYAN}•5${NC}] $bd Check User Login SSH & OpenVPN ${NC}"                                                 
echo -e "[${CYAN}•6${NC}] $bd Daftar Member SSH & OpenVPN ${NC}"                                                    
echo -e "[${CYAN}•7${NC}] $bd Padam User SSH & OpenVPN Exp ${NC}"                                                   
echo -e "[${CYAN}•8${NC}] $bd Set up Autokill SSH ${NC}"                                                            
echo -e "[${CYAN}•9${NC}] $bd Check User Multi Login SSH ${NC}"                                                     
echo -e "[${CYAN}10${NC}] $bd Restart All Service${NC} "                                                            
echo -e""                                                                                                           
echo -e "[${RED}•x${NC}] ${RED} Menu${NC}"
echo -e""
read -p "  Please Enter The Number  [1-9 or x] :  "  menu
echo -e ""
case $menu in
1)
addssh
;;
2)
trialssh
;;
3)
renewssh
;;
4)
delssh
;;
5)
cekssh
;;
6)
member
;;
7)
delexp
;;
8)
autokill
;;
9)
ceklim
;;
10)
restart
;;
x)
exit
;;
*)
echo "Masukkan Nomor Yang Ada"
sleep 1
menu-ssh
;;
esac
