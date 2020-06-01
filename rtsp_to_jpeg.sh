#!/usr/bin/env bash
source credentials.txt
# Where the videos will be saved
BASE_PATH=${VIDEO_RECORD_HOME_DIR}
REC_PATH=${BASE_PATH}'/timelapse'
CAM1=${CAMERA_NAME}
CAM1_JPEG_PATH="${VIDEO_CURL_PATH}"
mkdir ${REC_PATH}
mkdir ${REC_PATH}/${CAM1}

curl_jpeg(){
FILENAME="`date +%Y-%m-%d_%H.%M.%S -d '-7 hours'`"
curl -vvv -o $1/${FILENAME}.jpg $2
}
rtsp_jpeg(){
FILENAME="`date +%Y-%m-%d_%H.%M.%S -d '-7 hours'`"
ffmpeg -i $2 -f image2 -vframes 1  -r 1 $1/${FILENAME}.jpg

}

#since crontab only gives us ability to schedule our script calls every minute, we can do several snapshots within minute
# and separate it with sleeps
curl_jpeg ${REC_PATH}/${CAM1} ${CAM1_JPEG_PATH}
#rtsp_jpeg ${REC_PATH}/${CAM1} ${VIDEO_RTSP_PATH}
sleep 20
curl_jpeg ${REC_PATH}/${CAM1} ${CAM1_JPEG_PATH}
#rtsp_jpeg ${REC_PATH}/${CAM1} ${VIDEO_RTSP_PATH}
sleep 20
curl_jpeg ${REC_PATH}/${CAM1} ${CAM1_JPEG_PATH}
#rtsp_jpeg ${REC_PATH}/${CAM1} ${VIDEO_RTSP_PATH}

