#!/bin/bash

echo "Domain adınızı giriniz"
# Kullanıcıdan domain adını al
read -p "Lütfen domain adını giriniz (örn: react.mulosbron.xyz): " DOMAIN

echo "Nginx ve Certbot yükleniyor..."
# Nginx ve Certbot'un yüklenmesi
sudo apt-get install nginx python3-certbot-nginx -y
echo "Nginx ve Certbot yüklendi."

echo "React uygulamasının klasörü oluşturuluyor..."
# React uygulamasının klasörünün oluşturulması ve dosyaların kopyalanması
sudo mkdir -p /var/www/html/react
sudo cp -r /root/reactapp/build/* /var/www/html/react/
sudo chown -R www-data:www-data /var/www/html/react
echo "Klasör oluşturuldu ve dosyalar kopyalandı."

echo "Nginx site konfigürasyonu düzenleniyor..."
# Nginx site konfigürasyonunun düzenlenmesi
sudo nano /etc/nginx/sites-available/$DOMAIN
echo "Nginx site konfigürasyonu düzenlendi."

echo "Sembolik bağ oluşturuluyor ve Nginx yeniden başlatılıyor..."
# Sembolik bağın oluşturulması ve Nginx'in yeniden başlatılması
sudo ln -s /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
echo "Nginx yeniden başlatıldı."

echo "SSL sertifikası alınıyor..."
# SSL sertifikasının alınması
sudo certbot --nginx -d $DOMAIN
echo "SSL sertifikası alındı."