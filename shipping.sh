echo -e "\e[36m Installing Maven  \e[0m"
yum install maven -y

echo -e "\e[36m Adding roboshop user \e[0m"
useradd roboshop

echo -e "\e[36m Creating Application folder \e[0m"
mkdir /app
rm -rf /app/*

echo -e "\e[36m Downloading Shipping files \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app
unzip /tmp/shipping.zip

cd /app

echo -e "\e[36m Cleaning Maven package \e[0m"
mvn clean package
mv target/shipping-1.0.jar shipping.jar

echo -e "\e[36m Copying service file \e[0m"
cp ${code_dir}/configs/shipping.service /etc/systemd/system/shipping.service

echo -e "\e[36m Reloading the Service \e[0m"
systemctl daemon-reload

echo -e "\e[36m Enabling shipping Service  \e[0m"
systemctl enable shipping

echo -e "\e[36m Starting shipping Service  \e[0m"
systemctl start shipping

echo -e "\e[36m Installing MYSQL \e[0m"
yum install mysql -y

echo -e "\e[36m Connecting Mysql database \e[0m"
mysql -h mysql.devops-practice.tech -uroot -pRoboShop@1 < /app/schema/shipping.sql

echo -e "\e[36m Restarting the shipping Service  \e[0m"
systemctl restart shipping