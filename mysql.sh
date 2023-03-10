source common.sh

mysql_root_password=$1
if [ -z "${mysql_root_password}" ]; then
echo "Missing MYSQL Root Password argument"
exit 1
fi


print_head "Disabling MySQL 8 Version"
dnf module disable mysql -y
status_check $?

print_head "Installing MySQL Server"
yum install mysql-community-server -y
status_check $?

print_head "Enable MYSQL Service"
systemctl enable mysqld
status_check $?

print_head "Start MYSQL Service"
systemctl restart mysqld  
status_check $?

print_head "Set Password"
mysql_secure_installation --set-root-pass ${mysql_root_password
status_check $?
