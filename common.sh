code_dir=$(pwd)

log_file=/tmp/roboshop_log.log

rm -f ${log_file}

print_head() {
  echo -e "\e[36m $1 \e[0m"
}