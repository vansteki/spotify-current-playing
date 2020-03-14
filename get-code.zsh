#!/bin/zsh
#set - x

[ -f .env ] && source .env

function get_code() {
  echo 1.Remember to launch callback server by \"node callback-server.js\"
  echo 2.Paste link below to your browser, and getting your code 👇:
  echo "https://accounts.spotify.com/authorize?client_id=$CLIENT_ID&response_type=code&redirect_uri=$REDIRECT_URI&scope=$SCOPE"
  echo -n "Paste your code here:"
  read CODE

  if [ ! -z $CODE ]
  then
    CODE=$(echo $CODE | tr -d '"')
    echo -n "Save code to .env"
    sed -i "_backup"  "s/CODE=\"\"/CODE=\"$CODE\"/g" .env
  fi
}

function use_code_to_get_tokens() {
  echo "Get code and refresh token: \n"

  RESULT=`curl -X "POST" "$REFRESH_TOKEN_API" \
     -H 'Content-Type: application/x-www-form-urlencoded; charset=utf-8' \
     --data-urlencode "grant_type=authorization_code" \
     --data-urlencode "code=$CODE" \
     --data-urlencode "client_id=$CLIENT_ID" \
     --data-urlencode "client_secret=$CLIENT_SECRET" \
     --data-urlencode "redirect_uri=$REDIRECT_URI"
  `

  ACCESS_TOKEN=$(echo $RESULT | fx .access_token)
  echo "ACCESS TOKEN:\n $ACCESS_TOKEN \n"
  sed -i "_backup"  "s/ACCESS_TOKEN=\"\"/ACCESS_TOKEN=\"$ACCESS_TOKEN\"/g" .env

  REFRESH_TOKEN=$(echo $RESULT | fx .refresh_token)
  echo "REFRESH TOKEN:\n $REFRESH_TOKEN \n"
  sed -i "_backup"  "s/REFRESH_TOKEN=\"\"/REFRESH_TOKEN=\"$REFRESH_TOKEN\"/g" .env
}

get_code
use_code_to_get_tokens
