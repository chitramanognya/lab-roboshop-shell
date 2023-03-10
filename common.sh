code_dir=$(pwd)
log_file=/tmp/roboshop.log
rm -rf ${log_file}

print_head() {
   echo -e "\e[35m$1\e[0m" 
}

status_check() {
    if [$1 -eq 0 ]; then
    echo success
    else
    echo FAILURE
    fi
}