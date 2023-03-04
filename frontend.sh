
echo Install Nginx
yum install nginx -y

echo enable Nginx
systemctl enable nginx

echo start Nginx
systemctl start nginx

echo Remove old files
rm -rf /usr/share/nginx/html/*

echo download Frontend files
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo change directory
cd /usr/share/nginx/html

echo unzip the downloaded files
unzip /tmp/frontend.zip

echo restart Nginx
systemctl restart nginx