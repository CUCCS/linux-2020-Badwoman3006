#!/usr/bin/env bash


function showAll(){
  filename="${1}"
  statsAge "${filename}"
  statsPosition "${filename}"
  namelength "${filename}"

  return 0
}

function usehelp(){
  cat <<END_EOF
  Usage: bash Task_2.sh <filename>[arguments]
 

 Arguments:
  all		Show all information
  -a		Show age ,including maximum age and mimimum age
  -p		Show position status
  -n		Show the longest name and the shortest name
  -h		Show help information
END_EOF
return 0
}

#统计不同年龄区间范围的球员数量及百分比
function Age(){

  filename="${1}"

  twenty=$(awk ' BEGIN{FS="\t"} $6<20 && NR != 1 {print $6}' "${filename}"|wc -l)

  twenty2thrity=$(awk ' BEGIN{FS="\t"} $6>=20 && $6 <= 30 && NR != 1 {print $6}' "${filename}"|wc -l)

  thrity=$(awk ' BEGIN{FS="\t"} $6>30 && NR != 1 {print $6}' "${filename}"|wc -l)

  total=$( wc -l < "${filename}")
  total=$(( total - 1))
  printf "\n<====================Age Groups====================>\n"
  printf "Number of athletes under 20 years of age:%4d people\n" "${twenty}"
  val=$(echo "scale=2;100*$twenty/$total"|bc)
  printf "Percentage:%4.2f%%\n" "${val}"
  printf "Number of players aged 20 to 30:%4d people\n" "${twenty2thrity}"
  val=$(echo "scale=2;100*$twenty2thrity/$total"|bc)
  printf "Percentage:%4.2f%%\n" "${val}"
  printf "Number of players over 30 years of age:%4d people\n" "${thrity}"
  val=$(echo "scale=2;100*$thrity/$total"|bc)
  printf "Percentage:%4.2f%%\n\n" "${val}"
  printf "\n<==========The oldest player==========>\n"
  
  age=$(awk ' BEGIN {FS="\t";maxage=0} NR!=1 {if($6>maxage) {maxage=$6}} END {print maxage}' "${filename}")
  printf "Age:%d\n" "${age}"
  oldest=$(awk ' BEGIN {FS="\t"} NR!=1 {if($6=='"${age}"') {print $9}}' "${filename}")
  echo "${oldest}"
  printf "\n<==========The youngest player==========>\n"

  age=$(awk ' BEGIN {FS="\t";minage=100} NR!=1 {if($6<minage) {minage=$6}} END {print minage}' "${filename}")
  printf "Age:%d\n" "${age}"
  youngest=$(awk ' BEGIN {FS="\t"} NR!=1 {if($6=='"${age}"') {print $9}}' "${filename}")
  echo "${youngest}"

  return 0

}

#统计不同场上位置的球员数量及百分比
function Position(){
  filename="${1}"

  total=$( wc -l < "${filename}")
  total=$(( total - 1))

  printf "\n<==========Player's on-site location information==========>\n"
  position=$(awk ' BEGIN {FS="\t"} NR!=1 {if ($5=="Défenseur") {print "Defender"} else {print $5} }' "${filename}" | sort -f | uniq -c )
  test=$(echo "${position}" | awk '{printf("Position:%-10s\tNumber:%d\tpercentage:%4.2f%%\n",$2,$1,100*$1/'"${total}"')}')
  echo "${test}" 

  return 0
}

#统计名字最长最短的球员
function name(){
  filename="${1}"

  printf "\n<==========The longest-named player==========>\n"

  leng=$(awk ' BEGIN {FS="\t";lolen=0} NR!=1 {if(length($9)>lolen) {lolen=length($9)}} END {print lolen}' "${filename}")
  printf "Name Length:%d\n" "${leng}"
  longest=$(awk ' BEGIN {FS="\t"} NR!=1 {if(length($9)=='"${leng}"') {print $9}}' "${filename}")
  echo "${longest}"

  printf "\n<==========The shortest-named player==========>\n"

  leng=$(awk ' BEGIN {FS="\t";shlen=1000} NR!=1 {if(length($9)<shlen) {shlen=length($9)}} END {print shlen}' "${filename}")
  printf "Name Length:%d\n" "${leng}"
  shortest=$(awk ' BEGIN {FS="\t"} NR!=1 {if(length($9)=='"${leng}"') {print $9}}' "${filename}")
  echo "${shortest}"

  return 0
}

filename=${1}
shift
while [ -n "${1}" ]
do
  case "${1}" in 

    -h|--help)
      usehelp
      ;;
    -all)
      showAll "${filename}"
      ;;
    -a)
      Age "${filename}"
      ;;
    -p)
      Position "${filename}"
      ;;
    -n)
      name "${filename}"
      ;;
    *)
      echo "ERROR:${1} is not an option"
      ;;
  esac
  shift
done

