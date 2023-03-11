source common.sh

print_head " Downloading Redis repo file "
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${log_file}

print_head " Enabling the Redis 6.2 version "
dnf module enable redis:remi-6.2 -y &>>${log_file}

print_head " Installing Redis  "
yum install redis -y &>>${log_file}

#edit file vim /etc/redis.conf & vim /etc/redis/redis.conf
print_head " Setting Listen address "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf &>>${log_file}
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf &>>${log_file}

print_head " Enabling Redis service "
systemctl enable redis &>>${log_file}

print_head " Start Redis service "
systemctl restart redis &>>${log_file}