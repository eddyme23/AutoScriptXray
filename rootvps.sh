# by givpn
# ipinfo
MYIP=$(wget -qO- ipinfo.io/ip);
wget -qO- -O /etc/ssh/sshd_config https://raw.githubusercontent.com/givpn/autoscriptxray/master/sshd_config;
systemctl restart sshd;
clear;
echo -e "Enter Password:";
read -e pwe;
usermod -p `perl -e "print crypt("$pwe","Q4")"` root;
clear;
printf "Please Save This VPS Account Information"
if
echo ""
echo -e "Please Save This VPS Account Information"
echo -e "---------------------------------------------"
echo -e "Root Account (Main Account)"
echo -e "Ip address = $MYIP"
echo -e "Port       = 22 or 657"
echo -e "Username   = root"
echo -e "Password   = $pwe"
echo -e "---------------------------------------------"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
exit
fi
