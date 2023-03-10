source common.sh

mysql_root_password=$1
if [ -z "${mysql_root_password}" ]; then
echo "Missing MYSQL Root Password argument"
exit 1
fi


print_head "Disabling MySQL 8 Version"
dnf module disable mysql -y &>>${log_file}
status_check $?

print_head "Copy MySQL repo file"
cp ${code_dir}/configs/mysql.repo /etc/yum.repos.d/mysql.repo &>>${log_file}
status_check $?

print_head "Installing MySQL Server"
yum install mysql-community-server -y &>>${log_file}
status_check $?

print_head "Enable MYSQL Service"
systemctl enable mysqld &>>${log_file}
status_check $?

print_head "Start MYSQL Service"
systemctl restart mysqld &>>${log_file} 
status_check $?

print_head "Set Password"
echo show databases | mysql -uroot -p${mysql_root_password} &>>${log_file}
if [ $? -ne 0 ]; then
mysql_secure_installation --set-root-pass ${mysql_root_password} &>>${log_file}
fi
status_check $?
