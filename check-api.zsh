TEST_API="https://api.spotify.com/v1/me"
GET_CURRENT_PLAY_API="https://api.spotify.com/v1/me/player/currently-playing"
REFRESH_TOKEN_API="https://accounts.spotify.com/api/token"

TEST_HEADER=`curl -s "$TEST_API" \
  -H "Authorization: Bearer $1"`

TOKEN_STATUS=`curl -Is "$TEST_API" -o /dev/null -w "%{http_code}" \
  -H "Authorization: Bearer $1"`
