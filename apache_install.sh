#!/bin/sh

### Apache Instalation ###

echo "Installing Apache Web Server & Conf Server...please wait"

yum -y install httpd mod_ssl
mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf_default-bkp
wget s3.com/httpd.conf -P /etc/httpd/conf
wget s3.com/ssl.conf -P /etc/httpd/conf.d/

service httpd start

### SSL configuration ###

mkdir -p /etc/httpd/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/httpd/ssl/apache.key -out /etc/httpd/ssl/apache.crt -subj "/C=GB/ST=London/L=London/O=Global Security/OU=IT Department/CN=example.com"

### Stop Iptables & check SELINUX###
service iptables status
service iptables stop
sestatus

### Restart Apache ## 
service httpd restart

echo "Done!"
