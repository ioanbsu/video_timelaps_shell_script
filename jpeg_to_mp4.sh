#!/usr/bin/env bash
source credentials.txt

BASE_PATH=${VIDEO_RECORD_HOME_DIR}
REC_PATH=${BASE_PATH}'/timelapse'
CAM1=${CAMERA_NAME}
OUTPUT_PATH=$BASE_PATH'/video'
CAM1=${CAMERA_NAME}

mkdir ${OUTPUT_PATH}

# my linux box using UTC timezone, so converting it to my(PT) timezone when calculating file name.
date_value="`date +%Y-%m-%d -d '-7 hours'`"
cam1_output_file_name=${OUTPUT_PATH}/${date_value}-${CAM1}.mp4
# converting jpegs to mp4 video
ffmpeg -f image2 -i ${REC_PATH}/${CAM1}/%*.jpg -vcodec libx264 -r 60 -strftime 1 ${cam1_output_file_name} -y

upload_to_gdrive () {
echo uploading $2 $3
  curl -X POST -L \
      -H "Authorization: Bearer $1" \
      -F "metadata={name : '$2', parents:['${GDRIVE_FOLDER}']};type=application/json;charset=UTF-8" \
      -F "file=@$3;type=video/mp4" \
      "https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart"
}
echo getting access token...
# this is where we pipe output of curl to jq and pull access token from it.
gdrive_access_token=$(curl -X POST -d "redirect_uri=urn:ietf:wg:oauth:2.0:oob" -d "client_id=${GDRIVE_CLIENT_ID}" -d "grant_type=refresh_token" -d "client_secret=${GDRIVE_CLIENT_SECRET}" -d "refresh_token=${GDRIVE_REFRESH_TOKEN}" https://oauth2.googleapis.com/token|jq -r .access_token)
upload_to_gdrive $gdrive_access_token ${date_value}-${CAM1}.mp4  ${cam1_output_file_name}

#cleaning up
rm -rf ${REC_PATH}/${CAM1}/*.jpg
rm -rf ${cam1_output_file_name}

