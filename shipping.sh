source common.sh

mysql_root_password=$1

if [ -z "${mysql_root_password}" ]; then
   echo "Missing MySQL Root Password arguement"
   exit 1
fi

component=shipping
schema_type="mysql"
 java