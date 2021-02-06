## Install Requiriment And update System
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get -y install sudo nano git zip unzip net-tools sudo wget curl bash-completion
sudo apt-get -y install software-properties-common dirmngr
sudo apt-get -y install apt-transport-https lsb-release ca-certificates
sudo apt-get -y install python-software-properties

## Add Nginx Source List
echo "deb http://nginx.org/packages/ubuntu/ xenial nginx" >> /etc/apt/sources.list
echo "deb-src http://nginx.org/packages/ubuntu/ xenial nginx" >> /etc/apt/sources.list

## Add MariaDB Source List
echo "deb [arch=amd64,i386] http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.2/ubuntu xenial main" >> /etc/apt/sources.list
echo "deb-src http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.2/ubuntu xenial main" >> /etc/apt/sources.list

## Add Repo For PHP 7.2 & Properties Software
sudo add-apt-repository ppa:ondrej/php

## Nginx Key Pairing
wget https://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key

## MariaDB Key Pairing
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8

apt-get -y update

apt-get -y install nginx
apt-get -y install mariadb-server 
apt-get -y install php7.2 php7.2-common php7.2-cli php7.2-fpm php7.2-mysql php7.2-curl php7.2-gd php7.2-cgi php7.2-json php7.2-mbstring php7.2-dom php-imagick

# Search PHP Modul sudo apt-cache search php7*

## Optional Secue Instalation
sudo mysql_secure_installation

# Make Sure All System Set
systemctl restart nginx
systemctl restart php7.2-fpm

# Set System On Boot
systemctl enable nginx

# Install Composer PHP
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# Other Info
# if you get some error message like 
# 2014/09/17 00:17:30 [crit] 11909#0: *34 connect() to unix:/var/run/php-fpm.sock failed (13: Permission denied) while connecting to upstream, client: 127.0.0.1, server: www.ehowstuff.com, request: "GET /feed/ HTTP/1.1", upstream: "fastcgi://unix:/var/run/php-fpm.sock:", host: "www.ehowstuff.com"
# You Have To Edit on php pool config /etc/php/7.2/fpm/pool.d/www.conf and change + uncomment line blow 
# listen.owner = www-data
# listen.group = www-data
# listen.mode = 0666
# Don't forget to give permisson to working or sever diectory
# chown -R www-data:www-data /to/your/directory

# Lets Setup The VHost Sample Code Virtual Host

server {
    listen       80 default_server;
    server_name  localhost;
    root   /srv/default;
    index  index.html index.php index.htm;

    #charset koi8-r;
    #access_log  /var/log/nginx/host.access.log  main;

    location / {
       try_files $uri $uri/ /index.php?$query_string;
    }

    # proxy the PHP scripts to Apache listening on 127.0.0.1:80
    #
    #location ~ \.php$ {
    #    proxy_pass   http://127.0.0.1;
    #}

    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #
    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
        fastcgi_index  index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include        fastcgi_params;
    }

    # deny access to .htaccess files, if Apache's document root
    # concurs with nginx's one
    #
    location ~ /\.ht {
        deny  all;
    }
}

# NodeJS 8
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential

# Install Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn

# Install LetsEncrpt CertBot
sudo apt-get update
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install python-certbot-nginx

# Install CertBot For Nginx 
sudo certbot --nginx

# Setup SSL For Domain
sudo certbot --nginx certonly

# AutoRenewal CertBot SSL Certificate
sudo certbot renew --dry-run

# Install Wine
sudo dpkg --add-architecture i386 

# Add Repo Wne
sudo wget -nc https://dl.winehq.org/wine-builds/Release.key
sudo apt-key add Release.key
sudo apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/
sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ xenial main'
sudo apt-get update
sudo apt-get install --install-recommends winehq-stable

# add Repo Sticky Note Ubuntu
sudo add-apt-repository ppa:umang/indicator-stickynotes
sudo apt-get update
sudo apt-get install indicator-stickynotes
