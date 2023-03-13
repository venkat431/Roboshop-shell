source common.sh

print_head " Installing Python"
yum install python36 gcc python3-devel -y &>>${log_file}
status_chceck $?

app_prereq_setup

cd /app &>>${log_file}
print_head " Install payment requirements "
pip3.6 install -r requirements.txt &>>${log_file}
status_check $?

systemd_setup