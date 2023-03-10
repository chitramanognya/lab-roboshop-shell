source common.sh

roboshop_app_password=$1
if [ -z "${roboshop_app_password}" ]; then
echo "MissingRabbiMQ App User Password argument"
exit 1
fi

component=payment
python