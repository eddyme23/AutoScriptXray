</p> 
<h2 align="center"> Supported Linux Distribution</h2>
<p align="center"><img src="https://d33wubrfki0l68.cloudfront.net/5911c43be3b1da526ed609e9c55783d9d0f6b066/9858b/assets/img/debian-ubuntu-hover.png"></p> 
<p align="center"><img src="https://img.shields.io/static/v1?style=for-the-badge&logo=debian&label=Debian%209&message=Stretch&color=purple"> <img src="https://img.shields.io/static/v1?style=for-the-badge&logo=debian&label=Debian%2010&message=Buster&color=purple">  <img src="https://img.shields.io/static/v1?style=for-the-badge&logo=ubuntu&label=Ubuntu%2018&message=Lts&color=red"> <img src="https://img.shields.io/static/v1?style=for-the-badge&logo=ubuntu&label=Ubuntu%2020&message=Lts&color=red">
</p>
</div>

# Required
<br>
- DOMAIN (MUST)<br>
- DEBIAN 9/10<br>
- Ubuntu 18/20 LTS<br>
- CPU MIN 1 CORE<br>
- RAM 1GB<br>
<br>

# Setting Cloudflare
<br>
- SSL/TLS : FULL<br>
- SSL/TLS Recommender : OFF<br>
- GRPC : ON<br>
- WEBSOCKET : ON<br>
- Always Use HTTPS : OFF<br>
- UNDER ATTACK MODE : OFF<br>
<br>

## Service & Port:
<br>
- SSH Websocket : 80<br>
- SSH SSL Websocket : 443<br>
- Stunnel4 : 222,777<br>
- Vmess WS TLS : 443<br>
- Vless WS TLS : 443<br>
- Trojan WS TLS : 443<br>
- Shadowsocks WS TLS : 443<br>
- Vmess WS none TLS : 80<br>
- Vless WS none TLS : 80<br>
- Trojan WS none TLS : 80<br>
- Shadowsocks WS none TLS : 80<br>
- Vmess gRPC : 443<br>
- Vless gRPC : 443<br>
- Trojan gRPC : 443<br>
- Shadowsocks gRPC : 443<br>
<br>

# Service Status
![Service Status](https://raw.githubusercontent.com/givpn/AutoScriptXray/master/menu/image.png)

# INSTALLATION SCRIPT
```
sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && apt install -y bzip2 gzip coreutils screen curl unzip && wget https://raw.githubusercontent.com/givpn/AutoScriptXray/master/setup.sh && chmod +x setup.sh && sed -i -e 's/\r$//' setup.sh && screen -S setup ./setup.sh
```
<br>
- Permission first before install (FREE)<br>

# Telegram
[![Telegram-chat](https://raw.githubusercontent.com/givpn/telegram-button/main/chat-telegram.png)](https://t.me/givpn/)
[![Telegram-grup](https://raw.githubusercontent.com/givpn/telegram-button/main/grup-telegram.png)](https://t.me/givpn_grup)

# Donation Thanks for your support me
[![Saweria donate button](https://raw.githubusercontent.com/givpn/donation-button/main/saweria.png)](https://saweria.co/givpn11)
[![PayPal donate button](https://raw.githubusercontent.com/givpn/donation-button/main/paypal.png)](https://paypal.me/givpn11)
[![Ko-fi donate button](https://raw.githubusercontent.com/givpn/donation-button/main/ko-fi.png)](https://ko-fi.com/givpn11)

# LICENSE
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
