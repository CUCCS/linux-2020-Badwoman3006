#!/usr/bin/env bash

function usehelp(){
  cat <<END_EOF	
  Usage: bash Task_3.sh <filename>[arguments]
  Arguments:
  -th		Statistics Access source host TOP 100 and the corresponding total number of occurrences,excluding IP and proxy
  -ti		Statistics Access source host TOP 100 and the total number of occurrences corresponding,excluding hosts and prxy
  -tu		Count the most frequently accessed URL TOP100
  -cs		Count the number of occurrences and corrseponding percentages of different response status codes
  -c4s		Statistics the TOP 10 corresponding to the different 4XX status codes and the total number of corresponding occurrences
  -osh		Given URL output TOP 100 access Source host
END_EOF
  return 0
}


#ͳ�Ʒ�����Դ����TOP100�ͷֱ��Ӧ���ֵ��ܴ���
function topHost(){
  filename="${1}"
  printf "\n<========================Source host TOP 100========================>\n"
  result=$( awk 'BEGIN{FS="\t"} $1 ~ /^(\w+\.)+[a-zA-Z]/ {print $1}' "${filename}" | sort | uniq -c | sort -nr | head -n 100 | awk 'BEGIN{FS=" "} {printf("Source host: %-35s\t Number: %d\n",$2,$1)}')
  echo "${result}"

  return 0
}

#ͳ�Ʒ�����Դ����TOP100IP�ͷֱ��Ӧ���ֵ��ܴ���
function topIp(){
  filename="${1}"
  printf "\n<================Source Host TOP IP================>\n"
  result=$(awk 'BEGIN{FS="\t"} $1 ~ /([0-9]{1,3}\.){3}[0-9]{1,3}/ {print $1}' "${filename}" | sort | uniq -c | sort -nr | head -n 100 | awk 'BEGIN{FS=" "} {printf("Source IP: %-15s\t Number: %d\n",$2,$1)}')
  echo "${result}"

  return 0
}

#ͳ����Ƶ�������ʵ�URLTOP100
function topUrl(){
  filename="${1}"
  printf "\n<================Most frequently accessed URLS TOP 100================>\n"
  result=$(awk 'BEGIN{FS="\t"} $5 != "/" {print $5}' "${filename}" | sort | uniq -c | sort -nr | head -n 100)
  echo "${result}"

  return 0
}

#ͳ�Ʋ�ͬ��Ӧ״̬��ĳ��ִ����Ͷ�Ӧ�ٷֱ�
function countResponseStatus(){
  filename="${1}"
  printf "\n<================Response Status Code condition================>\n"
  sum=$(awk 'BEGIN{FS="\t";sum=0} $6 ~ /[0~9]/ {sum=sum+1} END {print sum}' "${filename}")
  result=$(awk 'BEGIN{FS="\t"} $6 ~ /[0~9]/{print $6}' "${filename}" | sort | uniq -c | sort -nr | awk 'BEGIN{FS=" "} {printf("Status code: %-10s\t Number: %-20d\t Percentage:%-4.5f%%\n",$2,$1,100*$1/'"${sum}"')}')
  echo "${result}"

  return 0
}

#�ֱ�ͳ�Ʋ�ͬ4XX״̬���Ӧ��TOP 10 URL�Ͷ�Ӧ���ֵ��ܴ���
function count4XXStatus(){
  filename="${filename}"

  printf "\n<=================4XX status codes URL TOP 10=================>\n"

  codes=$(awk 'BEGIN{FS="\t"} $6 ~ /[4][0-9][0-9]/ {print $6}' "${filename}" | sort -u )

  echo "${codes}"

  for key in $codes
  do
    printf "Status code: %10s\n" "${key}"
    result=$(awk 'BEGIN{FS="\t"} $6=='"${key}"' {print $5}' "${filename}" | sort | uniq -c | sort -nr | head -n 10 )
    echo "${result}"
  done

  return 0
} 

#����URL���TOP100������Դ����
function outputSourceHost(){
  filename="${1}"
  url="${2}"

  printf "Input URL: %-10s\n" "${url}"
  result=$(awk 'BEGIN{FS="\t"} $5==ur {print $1} ' ur="${url}" "${filename}" | sort | uniq -c | sort -nr | head -n 100 | awk 'BEGIN{FS=" "} {printf("Source host: %-20s\t Number: %d\n",$2,$1)}')
  echo "${result}"

  return 0
} 

filename=${1}
shift
while [ -n "${1}" ]
do
  case "${1}" in

    -h|--help)
      printHelp
      ;;
    -th)
      topHost "${filename}"
      ;;
    -ti)
      topIp "${filename}"
      ;;
    -tu)
      topUrl "${filename}"
      ;;
    -cs)
      countResponseStatus "${filename}"
      ;;
    -c4s)
      count4XXStatus "${filename}"
      ;;
    -osh)
      url="${2}"
      outputSourceHost "${filename}" "${url}"
      shift
      ;;
    *)
      echo "ERROR:${1} is not a option"
      ;;
  esac
  shift
done
