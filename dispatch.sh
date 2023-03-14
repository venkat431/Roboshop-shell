source common.sh

component=dispatch
print_head "Installing golang "
yum install golang -y &>>{log_file}
status_check $?

app_prereq_setup

cd /app

print_head "Initiate dispatch "
go mod init dispatch &>>{log_file}
status_check $?

print_head "Get "
go get &>>{log_file}
status_check $?

print_head "Build "
go build &>>{log_file}
status_check $?

systemd_setup
