source common.sh

print_head " Disabling Mysql  "
dnf module disable mysql -y &>>${log_file}

print_head " Copying mysql config file "
cp ${code_dir}/configs/mysql.repo /etc/yum.repos.d/mysql.repo &>>${log_file}

print_head " Installing mysql  "
yum install mysql-community-server -y &>>${log_file}

print_head " Enabling mysql service "
systemctl enable mysqld &>>${log_file}

print_head " Starting mysql serice "
systemctl restart mysqld &>>${log_file}

mysql_secure_installation --set-root-pass RoboShop@1 &>>${log_file}

print_head " Connecting Mysql "
#mysql -uroot -pRoboShop@1 &>>${log_file}

