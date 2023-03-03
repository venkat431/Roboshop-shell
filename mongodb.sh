
yum install mongodb-org -y
systemctl enable mongod
systemctl start mongod

#uodate 127.0.0.1 to 0.0.0.0 in conf file

systemctl restart mongod