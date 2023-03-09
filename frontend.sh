yum install nginx -y 
 rm -rf /usr/share/nginx/html/* 
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip
cp configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf
systemctl enable nginx 
systemctl start nginx
