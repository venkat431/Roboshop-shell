echo -e "\e[36m Disabling Mysql  \e[0m"
dnf module disable mysql -y

echo -e "\e[36m Copying mysql config file \e[0m"
cp ${code_dir}/configs/mysql.repo /etc/yum.repos.d/mysql.repo

echo -e "\e[36m Installing mysql  \e[0m"
yum install mysql-community-server -y

echo -e "\e[36m Enabling mysql service \e[0m"
systemctl enable mysqld

echo -e "\e[36m Starting mysql serice \e[0m"
systemctl start mysqld

echo -e "\e[36m Set root password \e[0m"
mysql_secure_installation --set-root-pass RoboShop@1

echo -e "\e[36m Connecting Mysql \e[0m"
mysql -uroot -pRoboShop@1

