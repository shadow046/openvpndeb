#!/bin/bash
MYIP=$(wget -qO- ipv4.icanhazip.com);
clear
echo -e ""
echo -e "\e[94m[][][]======================================[][][]"
echo -e "\e[0m                                                   "
echo -e "\e[93m          VPS Panel Installer By Shadow046        "
echo -e "\e[94m                                                  "
echo -e "\e[94m[][][]======================================[][][]\e[0m"
echo -e "\e[0m                                                   "
echo -e "\e[93m        Which Version Should Be Installed?        "
echo -e "\e[0m                                                   "
echo -e "\e[93m        [1] Version 1 (Simple Registration)       "
echo -e "\e[93m        [2] Version 2 (Free and VIP Options)      "
echo -e "\e[0m                                                   "
echo -e "\e[0m                                                   "
read -p "            Install Version [1-2] :  " Version
echo -e "\e[94m                                                  "
echo -e "\e[94m[][][]======================================[][][]\e[0m"
sleep 3
clear
echo -e "\e[0m                                                   "
echo -e "\e[94m[][][]======================================[][][]"
echo -e "\e[0m                                                   "
echo -e "\e[93m                Processing Request                "
echo -e "\e[94m            kape ka muna.. medyo matagal ito      "
echo -e "\e[94m[][][]======================================[][][]\e[0m"
sleep 3

apt-get update > /dev/null 2>1;
apt upgrade -y > /dev/null 2>1;
apt install ca-certificates apt-transport-https -y  > /dev/null 2>1;
wget -q https://packages.sury.org/php/apt.gpg -O- | sudo apt-key add - > /dev/null 2>1;
echo "deb https://packages.sury.org/php/ stretch main" | sudo tee /etc/apt/sources.list.d/php.list
apt update > /dev/null 2>1;
apt upgrade -y > /dev/null 2>1;
apt-get -y install nginx php5.6 php5.6-common php5.6-mcrypt php5.6-fpm php5.6-cli php5.6-mysql php5.6-xml > /dev/null 2>1;
sed -i 's@;cgi.fix_pathinfo=1@cgi.fix_pathinfo=0@g' /etc/php/5.6/fpm/php.ini
sed -i 's@enabled_dl[[:space:]]\=[[:space:]]Off@enabled_dl = On@g' /etc/php/5.6/fpm/php.ini
sed -i 's@listen = \/run\/php\/php5.6-fpm.sock@listen = 127.0.0.1:9000@g' /etc/php/5.6/fpm/pool.d/www.conf

rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget  --quiet -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/shadow046/openvpndeb/master/nginx.conf"
mkdir -p /home/panel/html/site
wget  --quiet -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/shadow046/openvpndeb/master/site.conf"
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf
service php5.6-fpm restart
service nginx restart
case $Version in
	1)
	cd /home/panel/html/site
	wget --quiet -O index.php "https://raw.githubusercontent.com/shadow046/openvpndeb/master/one.php"
	wget --quiet -O v1_server_details.php "https://raw.githubusercontent.com/shadow046/openvpndeb/master/v1.php"
	wget --quiet https://raw.githubusercontent.com/shadow046/openvpndeb/master/logo.png
	clear
	echo -e "\e[0m                                                   "
	echo -e "\e[94m[][][]======================================[][][]"
	echo -e "\e[0m                                                   "
	echo -e "\e[93m            Simple VPS Panel Installed            "
	echo -e "\e[93m      Dont Forget To Input The Server Details     "
	echo -e "\e[93m             at v1_server_details.php             "
	echo -e "\e[94m                                                  "
	echo -e "\e[93m                 "$MYIP:8020
	echo -e "\e[94m                                                  "
	echo -e "\e[94m[][][]======================================[][][]\e[0m"
	exit
	;;
	2)
	cd /home/panel/html/site
	wget --quiet -O index.php "https://raw.githubusercontent.com/shadow046/openvpndeb/master/two.php"
	wget --quiet -O v2_server_details.php "https://raw.githubusercontent.com/shadow046/openvpndeb/master/v2.php"
	wget --quiet https://raw.githubusercontent.com/shadow046/openvpndeb/master/logo.png
	clear
	echo -e "\e[0m                                                   "
	echo -e "\e[94m[][][]======================================[][][]"
	echo -e "\e[0m                                                   "
	echo -e "\e[93m            Simple VPS Panel Installed            "
	echo -e "\e[93m      Dont Forget To Input The Server Details     "
	echo -e "\e[93m             at v2_server_details.php             "
	echo -e "\e[94m                                                  "
	echo -e "\e[93m                 "$MYIP:8020
	echo -e "\e[94m                                                  "
	echo -e "\e[94m[][][]======================================[][][]\e[0m"
	exit
	;;
esac
service php5.6-fpm restart
service nginx restart
