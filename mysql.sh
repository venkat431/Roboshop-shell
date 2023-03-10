source common.sh

echo -e "\e[36m Disabling Mysql  \e[0m"
dnf module disable mysql -y &>>${log_file}

echo -e "\e[36m Copying mysql config file \e[0m"
cp ${code_dir}/configs/mysql.repo /etc/yum.repos.d/mysql.repo &>>${log_file}

echo -e "\e[36m Installing mysql  \e[0m"
yum install mysql-community-server -y &>>${log_file}

echo -e "\e[36m Enabling mysql service \e[0m"
systemctl enable mysqld &>>${log_file}

echo -e "\e[36m Starting mysql serice \e[0m"
systemctl start mysqld &>>${log_file}

mysql_secure_installation --set-root-pass RoboShop@1 &>>${log_file}

echo -e "\e[36m Connecting Mysql \e[0m"
#mysql -uroot -pRoboShop@1 &>>${log_file}

