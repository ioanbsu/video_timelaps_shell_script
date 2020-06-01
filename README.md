# JPEG/RTSP to timelapse MPEG and uploaded to google drive daily.
Set of shellscripts that convert videos from rtsp/jpeg cameras and upload result to google drive daily


## How to get google drive access/refresh token?
### initial get token
You'd need to do it one time onlye:
1. go to https://console.developers.google.com/apis/credentials and create DESKTOP client(click CREATE CREDENTIALS -> OAuth Client ID and select "desktop client" in application type).
Open created client and copy over client id and client secret to credentials.txt file. 
2. use this client to make request (using web browser):
 https://accounts.google.com/signin/oauth/oauthchooseaccount?access_type=offline&client_id=INSERT_CLIENT_ID_HERE&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&response_type=code&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fdrive&state=state&o2v=1&as=KXxQa_4txiUr-YPozBmnnw&flowName=GeneralOAuthFlow
3. exchange code. Previous response will give you a code that you can exchange to access token and refresh token. You use access token to make requests. You use refresh token to get new access token when it is expired. 
 ```curl POST -d "redirect_uri=urn:ietf:wg:oauth:2.0:oob" -d "client_id=INSERT_CLIENT_ID_HERE" -d "grant_type=authorization_code" -d "client_secret=INSERT_CLIENT_SECRET_HERE" -d "code=INSERT_CODE_AQUIRED_IN_PREVIOUS_STEP" https://oauth2.googleapis.com/token```
4. When access token is expired, you can use refresh token to get new access token(this step is optional as shel scripts in this repo are always usign refresh token to get access token before making request)  
  ```curl POST -d "redirect_uri=urn:ietf:wg:oauth:2.0:oob" -d "client_id=INSERT_CLIENT_ID_HERE"  -d "grant_type=refresh_token" -d "client_secret=INSERT_CLIENT_SECRET_HERE" -d "refresh_token=INSERT_REFERSH_TOKEN_HERE" https://oauth2.googleapis.com/token```
 
