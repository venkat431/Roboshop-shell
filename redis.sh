
echo -e "\e[36m Downloading Redis repo file \e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

echo -e "\e[36m Enabling the Redis 6.2 version \e[0m"
dnf module enable redis:remi-6.2 -y

echo -e "\e[36m Installing Redis  \e[0m"
yum install redis -y

#edit file vim /etc/redis.conf & vim /etc/redis/redis.conf
echo -e "\e[36m Setting Listen address \e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf

echo -e "\e[36m Enabling Redis service \e[0m"
systemctl enable redis

echo -e "\e[36m Start Redis service \e[0m"
systemctl start redis