source common.sh

mysql_root_Password = $1
if [ -z "${mysql_root_password}"  ] ;then
  echo -e "\e[31mMysql root password argument is missing\e[0m"
  exit 1
fi

print_head " Disabling Mysql  "
dnf module disable mysql -y &>>${log_file}
status_check $?

print_head " Copying mysql config file "
cp ${code_dir}/configs/mysql.repo /etc/yum.repos.d/mysql.repo &>>${log_file}
status_check $?

print_head " Installing mysql  "
yum install mysql-community-server -y &>>${log_file}
status_check $?

print_head " Enabling mysql service "
systemctl enable mysqld &>>${log_file}
status_check $?

print_head " Starting mysql serice "
systemctl restart mysqld &>>${log_file}
status_check $?

print_head " Starting mysql serice "

mysql_secure_installation --set-root-pass ${mysql_root_Password} &>>${log_file}
status_check $?

print_head " Connecting Mysql "
#mysql -uroot -pRoboShop@1 &>>${log_file}
status_check $?
