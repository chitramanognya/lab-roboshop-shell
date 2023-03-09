source common.sh


print_head "Configure NodeJs Repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

print_head "Install NodeJs"
yum install nodejs -y &>>${log_file}

print_head "Create Roboshop User"
useradd roboshop &>>${log_file}

print_head "Create Application Directory"
mkdir /app &>>${log_file}


print_head "Delete Old Content"
rm -rf /app/* &>>${log_file}

print_head "Downloading App content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log_file}
cd /app 

print_head "Extracting App content"
unzip /tmp/catalogue.zip &>>${log_file}


print_head "Installing NodeJs Dependencies"
npm install &>>${log_file}

print_head "copy SystemD Service file"
cp ${code_dir}configs/catalogue.service /etc/systemd/system/catalogue.service &>>${log_file}

print_head "Reload SystemD"
systemctl daemon-reload &>>${log_file}

print_head "Enable Catalogue service"
systemctl enable catalogue &>>${log_file} 

print_head "Start Catalogue service"
systemctl restart catalogue &>>${log_file}

print_head "Copy MongoDB Repo File"
cp ${code_dir}configs/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}

print_head "Install Mongod Client"
yum install mongod-org-shell -y &>>${log_file}

print_head "Load Schema"
mongo --host mongodb.learndevopsb71shop.site </app/schema/catalogue.js &>>${log_file}
