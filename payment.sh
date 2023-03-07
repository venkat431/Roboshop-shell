code_dir=$(pwd)

echo -e "\e[36m Installing Python \e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[36m Adding Application user \e[0m"
useradd roboshop

echo -e "\e[36m creating Application folder \e[0m"
mkdir /app
rm -rf /app/*

echo -e "\e[36m Reload the service \e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app
unzip /tmp/payment.zip

cd /app
pip3.6 install -r requirements.txt

cp ${code_dir}/configs/payment.service /etc/systemd/system/payment.service

echo -e "\e[36m Reload the service \e[0m"
systemctl daemon-reload

echo -e "\e[36m Enabling payment service \e[0m"
systemctl enable payment

echo -e "\e[36m Starting payment service \e[0m"
systemctl start payment
