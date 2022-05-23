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
#########################                                                                                                                            
                                                                                                                                                     
clear                                                                                                                                                
tr="$(cat /etc/xray/trojanxtls.json | grep port | sed 's/"//g' | sed 's/port//g' | sed 's/://g' | sed 's/,//g' | sed 's/ //g')"                      
echo -e "======================================"                                                                                                     
echo -e "         Xray Trojan Port Changer"                                                                                                          
echo -e ""                                                                                                                                           
echo -e "     [1]  Change Port Xray Trojan ${RED}$tr${NC}"                                                                                           
echo -e "     [x]  Exit"                                                                                                                             
echo -e ""                                                                                                                                           
echo -e "======================================"                                                                                                     
echo -e ""                                                                                                                                           
read -p "     Select From Options [1 or x] :  " port                                                                                                 
echo -e ""                                                                                                                                           
case $port in                                                                                                                                        
1)                                                                                                                                                   
read -p "Type New Port For Xray Trojan : " tr2                                                                                                       
if [ -z $tr2 ]; then                                                                                                                                 
echo "Please Input Port"                                                                                                                             
exit 0                                                                                                                                               
fi                                                                                                                                                   
cek=$(netstat -nutlp | grep -w $tr2)                                                                                                                 
if [[ -z $cek ]]; then                                                                                                                               
sed -i "s/$tr/$tr2/g" /etc/xray/trojanxtls.json                                                                                                      
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $tr -j ACCEPT                                                                           
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $tr -j ACCEPT                                                                           
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $tr2 -j ACCEPT                                                                          
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $tr2 -j ACCEPT                                                                          
iptables-save > /etc/iptables.up.rules                                                                                                               
iptables-restore -t < /etc/iptables.up.rules                                                                                                         
netfilter-persistent save > /dev/null                                                                                                                
netfilter-persistent reload > /dev/null                                                                                                              
systemctl restart trojanxtls > /dev/null                                                                                                             
clear                                                                                                                                                
echo -e "${GREEN}Succesfully Changed Xray Trojan Port To $tr2${NC}"                                                                                  
else                                                                                                                                                 
echo -e "${RED}Error ! ${NC}Port $tr2 Is Already Used"                                                                                               
fi                                                                                                                                                   
;;                                                                                                                                                   
x)                                                                                                                                                   
menu                                                                                                                                                 
;;                                                                                                                                                   
*)                                                                                                                                                   
echo "Please enter an correct number"                                                                                                                
;;                                                                                                                                                   
esac
