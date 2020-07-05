#!/usr/bin/env bash

function UseHelp(){
   cat <<END_EOF
  Usage: bash Task_1.sh [filename][arguments]


  Arguments
     -f		<filename> Select the file or folder to operate on
     -j		<maxSize> <maxWidth> <maxHeight> <quality>Support for image quality compression of JPEG formatted pictures
     -cr		<resolution> Supports compression resolution for JPEG/PNG/SVG format pictures while maintaining the original aspect ratio
     -w		<watermarks>  Support forbulk Add custom text watermarks to pictures
     -a		<-p|-s> <text> <imagetype>  Support for bulk renaming
     -t		Supports the uniform conversion of png/svg pictures to JPG formatted pictures

END_EOF

return0
}

# 压缩jpeg格式图片质量
# maxSize 图片尺寸允许值
# maxWidth 图片最大宽度
# maxHeight 图片最大高度
# quality 图片质量


#支持对jpeg格式图片进行图片质量压缩
function jpgQualityCompress(){
  path=${1}
  maxSize=${2}
  maxWidth=${3}
  maxHeight=${4}
  quality=${5}
  if [ -d "${path}" ];then
    files=$(find "${path}" \( -name "*.jpg" \) -type f -size +"${maxSize}" -exec ls {} \;);
    for file in ${files}
    do
      echo "${file}"
       convert -resize "${maxWidth}"x"${maxHeight}" "${file}" -quality "${quality}" "${file}"
    done
  elif [ -f "${path}" ]
  then
    echo "${path}"
    convert -resize "${maxWidth}"x"${maxHeight}" "${path}" -quality "${quality}" "${path}"
  fi

  return 0
}

#支持对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
function compressionResolution(){
  path=${1}
  resolution=${2}
  if [ -d "${path}" ]
  then
    files=$(find "${path}" \( -name "*.jpg" -or -name "*.png" -or -name "*.svg" \) -type f -exec ls {} \;);
    for file in ${files}
    do
      echo "${file}"
      # info=$(identify "${file}")
      # resolution=$(echo "${info}" | awk '{split($0,a," ");print a[3]}')
      convert -resize "${resolution}" "${file}" "${file}"
    done
  elif [ -f "${path}" ]
  then
    echo "${path}"
    # info=$(identify "${path}")
    # resolution=$(echo "${info}" | awk '{split($0,a," ");print a[3]}')
    convert -resize "${resolution}" "${path}" "${path}"
  fi

  return 0
}


#支持对图片批量添加自定义文本水印
function addWatermark(){
  path=${1}
  watermark=${2}

  if [ -d "${path}" ]
  then
    files=$(find "${path}" \( -name "*.jpg" -or -name "*.png" -or -name "*.svg" -or -name ".bmp" -or -name ".svg" \) -type f -exec ls {} \;);

    for file in ${files}
    do
      echo "${file}"
      echo "watermark: ${watermark} "
      convert ${file} -gravity southeast -fill black -pointsize 32 -draw " text 5,5 ${watermark} " "${file}"
    done

  elif [ -f "${path}" ]
  then
    echo "${path}"
    echo "watermark: ${watermark} "
    convert ${path} -gravity southeast -fill black -pointsize 64 -draw "text 5,5 ${watermark} " "${path}"
  fi

  return 0
}

#支持统一添加文件名后缀，不影响原始文件扩展名
addSuffix(){
  path="${1}"
  text="s/\.""${3}""$/""${2}"".""${3}""/"
  imagetype="*.""${3}"
  if [ -d "${path}" ]
  then
    echo "${path}"
    cd "${path}" || return 1
    rename "${text}" ${imagetype}
    cd ..
  elif [ -f "${path}" ]
  then
    echo "${path}"
    cd "${path%/*}" || return 1
    rename "${text}" ${path##*/}
    cd ..
  fi

  return 0

}

#支持统一添加文件名前缀，不影响原始文件扩展名
function addPrefix(){
  path="${1}"
  text="s/^/""${2}""/"
  imagetype="*.""${3}"
  if [ -d "${path}" ]
  then
    echo "${path}"
    cd "${path}" || return 1
    rename "${text}" ${imagetype}
    cd ..
  elif [ -f "${path}" ]
  then
    echo "${path}"
    cd "${path%/*}" || return 1
    mv "${path##*/}" "${2}""${path##*/}"
    cd ..
  fi

  return 0
}

# 支持将png/svg图片统一转换为jpg格式
function transform(){
  path="${1}"
  if [ -d "${path}" ]
  then
    files=$(find "${path}" \( -name "*.png" -or -name "*.svg" \) -type f -exec ls {} \;);
    for file in ${files}
    do
      file="${file##*/}"
      echo "${file}"
      cd "${path%/*}" || return 1
      convert "${file}" "${file%.*}"".jpg"
      cd ..
    done
  elif [ -f "${path}" ]
  then
    if [ "${path##*.}" == "svg" ] || [ "${path##*.}" == "png" ]
    then
      file="${path##*/}"
      echo "${file}"
      cd "${path%/*}" || return 1
      convert "${file}" "${file%.*}"".jpg"
      cd ..
    fi
  fi

  return 0
}

while [ -n "${1}" ]
do
  case "${1}" in

    -h|--help)
      printHelp
      ;;
    
    -f)
      if [ "${#}" == 1 ]
      then
        echo "Error: You must description of the file or folder to manipulate"
        exit 0 
      elif [ ! -d "${2}" ] && [ ! -f "${2}" ]
      then
        echo "Error: The directory or file dose not exist"
        exit 0
      fi
      path="${2}"
      echo "Choose File:${2}"
      shift
      ;;

    -j)
      maxSize=${2}
      maxWidth=${3}
      maxHeight=${4}
      quality=${5}
      jpgQualityCompress "${path}" "${maxSize}" "${maxWidth}" "${maxHeight}" "${quality}"
      shift
      shift
      shift
      shift
      ;;
    -cr)
      resolution=${2}
      compressionResolution "${path}" "${resolution}"
      shift
      ;;
    -w)
      watermark=${2}
      addWatermark "${path}" "${watermark}"
      shift
      ;;
    -a)
      position=${2}
      text=${3}
      imagetype=${4}
      if [ "${position}" == "-p" ]
      then
        addPrefix "${path}" "${text}" "${imagetype}"
      elif [ "${position}" == "-s" ]
      then
        addSuffix "${path}" "${text}" "${imagetype}"
      else
        echo "Error: There is a problem with the input parameters,you can choose the -p (prefix) or -s(suffix)"
      fi
      shift
      shift
      shift
      ;;
    -t)
      transform2Jpg "${path}"
      ;;
    *)
      echo "Error: ${1} is not an option"
      ;;
  esac
  shift
done


