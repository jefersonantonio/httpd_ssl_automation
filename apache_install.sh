#!/bin/sh

### Apache Instalation ###
echo "Installing Apache Web Server & Conf Server...please wait"

yum -y install httpd24 mod24_ssl
mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf_default-bkp
wget https://s3.com/httpd.conf -P /etc/httpd/conf
wget https://s3.com/ssl.conf -P /etc/httpd/conf.d/


### SSL configuration ###

mkdir -p /etc/httpd/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/httpd/ssl/apache.key -out /etc/httpd/ssl/apache.crt -subj "/C=GB/ST=London/L=London/O=Global Security/OU=IT Department/CN=example.com"


### Stop Iptables ###
service iptables status
service iptables stop

### Add hosts/ip to /etc/hosts ###
echo "10.237.171.12     login.example.com" >> /etc/hosts
echo "10.237.171.245      login.example.com" >> /etc/hosts
echo "10.237.171.13     hostname     example.com" >> /etc/hosts
echo "10.237.171.13     cname.example-pharma.com" >> /etc/hosts

### Restart Apache ##
chkconfig httpd on
service httpd start

echo "Done!!"
