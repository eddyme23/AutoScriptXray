#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################

BURIQ () {
    curl -sS https://ipinfo.io/ip > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f  /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f  /root/tmp
}
MYIP=$(curl -sS ipinfo.io/ip)
Name=$givpn
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="Permission Accepted..."
fi
}

PERMISSION () {
    MYIP=$(curl -sS ipinfo.io/ip)
    IZIN=$(curl -sS https://ipinfo.io/ip | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}

clear
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
BRed='\e[1;31m'
BGreen='\e[1;32m'
BBlue='\e[1;34m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
cd /root
#System version number
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi

localip=$(hostname -I | cut -d\  -f1)
hst=( `hostname` )
dart=$(cat /etc/hosts | grep -w `hostname` | awk '{print $2}')
if [[ "$hst" != "$dart" ]]; then
echo "$localip $(hostname)" >> /etc/hosts
fi

mkdir -p /etc/xray
mkdir -p /etc/v2ray
touch /etc/xray/domain
touch /etc/v2ray/domain
touch /etc/xray/scdomain
touch /etc/v2ray/scdomain


echo -e "[ ${BBlue}NOTES${NC} ] Before we go.. "
sleep 0.5
echo -e "[ ${BBlue}NOTES${NC} ] I need check your headers first.."
sleep 0.5
echo -e "[ ${BGreen}INFO${NC} ] Checking headers"
sleep 0.5
totet=`uname -r`
REQUIRED_PKG="linux-headers-$totet"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  sleep 0.5
  echo -e "[ ${BRed}WARNING${NC} ] Try to install ...."
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  apt-get --yes install $REQUIRED_PKG
  sleep 0.5
  echo ""
  sleep 0.5
  echo -e "[ ${BBlue}NOTES${NC} ] If error you need.. to do this"
  sleep 0.5
  echo ""
  sleep 0.5
  echo -e "[ ${BBlue}NOTES${NC} ] apt update && upgrade"
  sleep 0.5
  echo ""
  sleep 0.5
  echo -e "[ ${BBlue}NOTES${NC} ] After this"
  sleep 0.5
  echo -e "[ ${BBlue}NOTES${NC} ] Then run this script again"
  echo -e "[ ${BBlue}NOTES${NC} ] enter now"
  read
else
  echo -e "[ ${BGreen}INFO${NC} ] Oke installed"
fi

ttet=`uname -r`
ReqPKG="linux-headers-$ttet"
if ! dpkg -s $ReqPKG  >/dev/null 2>&1; then
  rm /root/setup.sh >/dev/null 2>&1 
  exit
else
  clear
fi


secs_to_human() {
    echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds"
}
start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1

echo -e "[ ${BGreen}INFO${NC} ] Preparing the install file"
apt install git curl -y >/dev/null 2>&1
apt install python -y >/dev/null 2>&1
echo -e "[ ${BGreen}INFO${NC} ] Aight good ... installation file is ready"
sleep 0.5
echo -ne "[ ${BGreen}INFO${NC} ] Check permission : "

PERMISSION
if [ -f /home/needupdate ]; then
BGreen "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
BGreen "Permission Accepted!"
else
BRed "Permission Denied!"
rm setup.sh > /dev/null 2>&1
sleep 0.5
exit 0
fi
sleep 0.5

mkdir -p /var/lib/ >/dev/null 2>&1
echo "IP=" >> /var/lib/ipvps.conf

echo ""
clear
wget -q "https://raw.githubusercontent.com/givpn/AutoScriptXray/master/ssh/cf.sh" && chmod +x cf.sh && ./cf.sh
clear
BRed "Wajib Tambah Domain Untuk XRAY"
echo " "
read -rp "Wajib Input domain kamu : " -e dns
    if [ -z $dns ]; then
        echo -e "
        Tidak memasukan domain...tenang
        Domain random dibuatkan"
    else
        echo "$dns" > /root/scdomain
	echo "$dns" > /etc/xray/scdomain
	echo "$dns" > /etc/xray/domain
	echo "$dns" > /etc/v2ray/domain
	echo $dns > /root/domain
        echo "IP=$dns" > /var/lib/ipvps.conf
    fi
    
#install ssh ovpn
echo -e "\e[33m-----------------------------------\033[0m"
echo -e "$BGreen      Install SSH Websocket           $NC"
echo -e "\e[33m-----------------------------------\033[0m"
sleep 0.5
clear
wget https://raw.githubusercontent.com/givpn/AutoScriptXray/master/ssh/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh
#Instal Xray
echo -e "\e[33m-----------------------------------\033[0m"
echo -e "$BGreen          Install XRAY              $NC"
echo -e "\e[33m-----------------------------------\033[0m"
sleep 0.5
clear
wget https://raw.githubusercontent.com/givpn/AutoScriptXray/master/xray/ins-xray.sh && chmod +x ins-xray.sh && ./ins-xray.sh
wget https://raw.githubusercontent.com/givpn/AutoScriptXray/master/sshws/insshws.sh && chmod +x insshws.sh && ./insshws.sh
clear
cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
menu
END
chmod 644 /root/.profile

if [ -f "/root/log-install.txt" ]; then
rm /root/log-install.txt > /dev/null 2>&1
fi
if [ -f "/etc/afak.conf" ]; then
rm /etc/afak.conf > /dev/null 2>&1
fi
if [ ! -f "/etc/log-create-user.log" ]; then
echo "Log All Account " > /etc/log-create-user.log
fi
history -c
serverV=$( curl -sS https://raw.githubusercontent.com/givpn/AutoScriptXray/master/menu/versi  )
echo $serverV > /opt/.ver
aureb=$(cat /home/re_otm)
b=11
if [ $aureb -gt $b ]
then
gg="PM"
else
gg="AM"
fi
curl -sS ipv4.icanhazip.com > /etc/myipvps
echo ""
echo "=================================================================="  | tee -a log-install.txt
echo "      ___                                    ___         ___      "  | tee -a log-install.txt
echo "     /  /\        ___           ___         /  /\       /__/\     "  | tee -a log-install.txt
echo "    /  /:/_      /  /\         /__/\       /  /::\      \  \:\    "  | tee -a log-install.txt
echo "   /  /:/ /\    /  /:/         \  \:\     /  /:/\:\      \  \:\   "  | tee -a log-install.txt
echo "  /  /:/_/::\  /__/::\          \  \:\   /  /:/~/:/  _____\__\:\  "  | tee -a log-install.txt
echo " /__/:/__\/\:\ \__\/\:\__   ___  \__\:\ /__/:/ /:/  /__/::::::::\ "  | tee -a log-install.txt
echo " \  \:\ /~~/:/    \  \:\/\ /__/\ |  |:| \  \:\/:/   \  \:\~~\~~\/ "  | tee -a log-install.txt
echo "  \  \:\  /:/      \__\::/ \  \:\|  |:|  \  \::/     \  \:\  ~~~  "  | tee -a log-install.txt
echo "   \  \:\/:/       /__/:/   \  \:\__|:|   \  \:\      \  \:\      "  | tee -a log-install.txt
echo "    \  \::/        \__\/     \__\::::/     \  \:\      \  \:\     "  | tee -a log-install.txt
echo "     \__\/                       ~~~~       \__\/       \__\/ 1.0 "  | tee -a log-install.txt
echo "=================================================================="  | tee -a log-install.txt
echo ""
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                  : 22"  | tee -a log-install.txt
echo "   - SSH Websocket            : 80 [OFF]" | tee -a log-install.txt
echo "   - SSH SSL Websocket        : 443" | tee -a log-install.txt
echo "   - Stunnel4                 : 222, 777" | tee -a log-install.txt
echo "   - Dropbear                 : 109, 143" | tee -a log-install.txt
echo "   - Badvpn                   : 7100-7900" | tee -a log-install.txt
echo "   - Nginx                    : 81" | tee -a log-install.txt
echo "   - Vmess WS TLS             : 443" | tee -a log-install.txt
echo "   - Vless WS TLS             : 443" | tee -a log-install.txt
echo "   - Trojan WS TLS            : 443" | tee -a log-install.txt
echo "   - Shadowsocks WS TLS       : 443" | tee -a log-install.txt
echo "   - Vmess WS none TLS        : 80" | tee -a log-install.txt
echo "   - Vless WS none TLS        : 80" | tee -a log-install.txt
echo "   - Trojan WS none TLS       : 80" | tee -a log-install.txt
echo "   - Shadowsocks WS none TLS  : 80" | tee -a log-install.txt
echo "   - Vmess gRPC               : 443" | tee -a log-install.txt
echo "   - Vless gRPC               : 443" | tee -a log-install.txt
echo "   - Trojan gRPC              : 443" | tee -a log-install.txt
echo "   - Shadowsocks gRPC         : 443" | tee -a log-install.txt
echo ""
echo "=============================Contact==============================" | tee -a log-install.txt
echo "---------------------------t.me/givpn-----------------------------" | tee -a log-install.txt
echo "==================================================================" | tee -a log-install.txt
echo -e ""
echo ""
echo "" | tee -a log-install.txt
rm /root/setup.sh >/dev/null 2>&1
rm /root/ins-xray.sh >/dev/null 2>&1
rm /root/insshws.sh >/dev/null 2>&1
secs_to_human "$(($(date +%s) - ${start}))" | tee -a log-install.txt
echo -e "
"
echo -ne "[ ${yell}WARNING${NC} ] reboot now ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi





