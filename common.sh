code_dir=$(pwd)

log_file=/tmp/roboshop_log.log
rm -f ${log_file}

print_head() {
  echo -e "\e[36m $1 \e[0m"
}

status_check() {
  if [ $1 -eq 0 ]; then
    echo SUCCESS
    else
      echo FAILURE
      exit 1
  fi
}

schema_setup() {
  if [ "${schema_type}" == "mongo" ]; then
    print_head " Copying MONGODB repo file  "
    cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}
    status_check $?

    print_head " Installing MongoDB client "
    yum install mongodb-org-shell -y &>>${log_file}
    status_check $?

    print_head " Load MongoDB database "
    mongo --host mongodb.devops-practice.tech </app/schema/${component}.js &>>${log_file}
    status_check $?
  fi
}

nodejs() {
print_head " Downloading Nodejs repo "
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}
status_check $?

print_head " Installing Nodejs "
yum install nodejs -y &>>${log_file}
status_check $?

print_head " Adding application user "
app_useradd
status_check $?

print_head " Creating Application directory "
if [ ! -d /app ]; then
  mkdir /app &>>${log_file}
fi
status_check $?

print_head " Removing Old files "
rm -rf /app/* &>>${log_file}
status_check $?

print_head " Downloading Catalogue files "
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
status_check $?

cd /app &>>${log_file}

print_head " Extracting Files "
unzip /tmp/catalogue.zip &>>${log_file}
status_check $?

cd /app &>>${log_file}

print_head " Installing npm packages "
npm install &>>${log_file}
status_check $?

print_head " Copying service file "
cp ${code_dir}/configs/${component}.service /etc/systemd/system/${component}.service &>>${log_file}
status_check $?

print_head " Reload Service file "
systemctl daemon-reload &>>${log_file}
status_check $?

print_head " Enabling ${component} service "
systemctl enable ${component} &>>${log_file}
status_check $?

print_head " Starting ${component}  service "
systemctl restart ${component} &>>${log_file}
status_check $?

schema_setup
}