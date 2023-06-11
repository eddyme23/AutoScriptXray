# by givpn
wget -qO- -O /etc/ssh/sshd_config https://raw.githubusercontent.com/givpn/autoscriptxray/master/sshd_config;
systemctl restart sshd;
clear;
echo -e "Enter Password:";
read -e pwe;
usermod -p `perl -e "print crypt("$pwe","Q4")"` root;
clear;
printf "Please Save This VPS Account Information
---------------------------------------------
Root Account (Main Account)
Ip address = $(curl -Ls http://ipinfo.io/ip)
Port       = 22
Username   = root
Password   = $pwe
---------------------------------------------
echo "";
exit;
