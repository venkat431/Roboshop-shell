
echo -e "\e[36m Installing Nginx \e[0m"
yum install nginx -y

echo -e "\e[36m Enabling Nginx \e[0m"
systemctl enable nginx

echo -e "\e[36m starting Nginx \e[0m"
systemctl start nginx

echo -e "\e[36m Remove old files \e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[36m download Frontend files \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo  -e "\e[36m change directory \e[0m"
cd /usr/share/nginx/html

echo  -e "\e[36m unzip the downloaded files \e[0m"
unzip /tmp/frontend.zip

echo  -e "\e[36m restart Nginx \e[0m"
systemctl restart nginx