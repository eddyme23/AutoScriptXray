#!/bin/bash
# cari apa
clear
apt install jq curl -y
DOMAIN=givpn.my.id
sub=$(</dev/urandom tr -dc a-z0-9 | head -c4)
SUB_DOMAIN=xray-${sub}.givpn.my.id
CF_ID=givpn11@gmail.com
CF_KEY=0f738ffa9cdbbb44a0a0cd77c0411fa12343e
set -euo pipefail
IP=$(wget -qO- ifconfig.me);
echo "Updating DNS for ${SUB_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')
echo "Host : $SUB_DOMAIN"
echo "IP=$SUB_DOMAIN" >> /var/lib/ipvps.conf
echo $SUB_DOMAIN > /root/domain
echo "$SUB_DOMAIN" > /root/scdomain
echo "$SUB_DOMAIN" > /etc/xray/scdomain
echo "$SUB_DOMAIN" > /etc/xray/domain
echo "$SUB_DOMAIN" > /etc/v2ray/domain
echo -e "Done Record Domain= ${SUB_DOMAIN} For VPS"
sleep 2
rm -f /root/cf.sh
