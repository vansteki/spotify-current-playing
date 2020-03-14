#!/bin/zsh
#set -x

[ -f .env ] && source .env

GET_CURRENT_PLAY_API="https://api.spotify.com/v1/me/player/currently-playing"
REFRESH_TOKEN_API="https://accounts.spotify.com/api/token"
CURRENT_PLAY=""

function check_token() {
  TEST_API="https://api.spotify.com/v1/me/player/currently-playing"

  #TEST_RESULT=`curl -s "$TEST_API" \
  #  -H "Authorization: Bearer $ACCESS_TOKEN"`
  
  TEST_API_STATUS_CODE=`curl -Is -X HEAD "$TEST_API" -o /dev/null -w "%{http_code}" \
    -H "Authorization: Bearer $ACCESS_TOKEN"`

  # echo "\n Try API: $TEST_API \n"
  # echo "\n Status Code: $TEST_API_STATUS_CODE \n"
}

function refresh_token() {
  ACCESS_TOKEN=`curl -s -X "POST" "$REFRESH_TOKEN_API" \
     -H 'Content-Type: application/x-www-form-urlencoded; charset=utf-8' \
     --data-urlencode "grant_type=refresh_token" \
     --data-urlencode "refresh_token=$REFRESH_TOKEN" \
     --data-urlencode "client_id=$CLIENT_ID" \
     --data-urlencode "client_secret=$CLIENT_SECRET" \
     | fx .access_token
  `
  sed -i "_backup_before_refresh_token" "s/ACCESS_TOKEN=\".*\"/ACCESS_TOKEN=\"$ACCESS_TOKEN\"/g" .env
}

function get_current_play() {
  while true; do
    check_token
    if [ $TEST_API_STATUS_CODE -eq 200 ]
      then
        CURRENT_PLAY=`curl -s "$GET_CURRENT_PLAY_API" \
           -H "Authorization: Bearer $ACCESS_TOKEN" | fx .item.name 2>/dev/null
        `
        printf "[%s] %s\n" $TEST_API_STATUS_CODE $CURRENT_PLAY
        sleep 10
        clear
    elif [ $TEST_API_STATUS_CODE -eq 401 ]
      then
        refresh_token
    else
      echo "Some thing went wrong :( \n echo $TEST_RESULT \n"
      exit 0    
    fi
  done
}

refresh_token
get_current_play
