source common.sh


print_head "Configure NodeJs Repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}
status_check $?

print_head "Install NodeJs"
yum install nodejs -y &>>${log_file}
status_check $?

print_head "Create Roboshop User"
id roboshop &>>${log_file}
if [ $? -ne 0 ]; then
useradd roboshop &>>${log_file}
fi 
status_check $?

print_head "Create Application Directory"
if [ ! -d /app ]; then

mkdir /app &>>${log_file}
fi
status_check $?


print_head "Delete Old Content"
rm -rf /app/* &>>${log_file}
status_check $?

print_head "Downloading App content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log_file}
cd /app
status_check $?

print_head "Extracting App content"
unzip /tmp/catalogue.zip &>>${log_file}
status_check $?


print_head "Installing NodeJs Dependencies"
npm install &>>${log_file}
status_check $?

print_head "copy SystemD Service file"
cp ${code_dir}/configs/catalogue.service /etc/systemd/system/catalogue.service &>>${log_file}
status_check $?

print_head "Reload SystemD"
systemctl daemon-reload &>>${log_file}
status_check $?

print_head "Enable Catalogue service"
systemctl enable catalogue &>>${log_file}
status_check $?

print_head "Start Catalogue service"
systemctl restart catalogue &>>${log_file}
status_check $?

print_head "Copy MongoDB Repo File"
cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}
status_check $?

print_head "Install Mongod Client"
yum install mongodb-org-shell -y &>>${log_file}
status_check $?

print_head "Load Schema"
mongo --host mongodb.learndevopsb71shop.site </app/schema/catalogue.js &>>${log_file}
status_check $?
