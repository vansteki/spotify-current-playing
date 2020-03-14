# spotify-current-playing
Use Spotify API to get current playing song

## Usage 

You may want to check [Authorization Guide](https://developer.spotify.com/documentation/general/guides/authorization-guide/)

### Install

1. install dependencies

Install Zsh
Install Nodejs or Python3

`brew install fx`

2. git clone this repo

`git clone https://github.com/vansteki/spotify-current-playing.git && cd spotify-current-playing`

3. copy .env file

`cp .env.template .env`

4. Go to [Spotify Dashboard](https://developer.spotify.com/dashboard/login) to regist your own app, then fill some form, then back to `.env`:

```
CODE=""
ACCESS_TOKEN=""
REFRESH_TOKEN=""
CLIENT_ID=""       // you can get this from Spotify dashboard
CLIENT_SECRET=""   // you can get this from Spotify dashboard
REDIRECT_URI=""    // you can just use http://localhost:8000, should to be same as REDIRECT URI in Spotify dashboard 
```

5. Launch local redirect server

`node callback-server.js` or `python3 -m http.server 8000`

6. Launch oyu Spotify, begin playing

7. Authentication

Make sure you can run scripts
`chmod 755 *.zsh`

Get code for exchanging access token and refresh token

run `./get-code.zsh`

just paste link to browser

```
1.Remember to launch callback server by "node callback-server.js"
2.Paste link below to your browser, and getting your code 👇:
https://accounts.spotify.com/authorize?client_id=276321612ge12e1a&response_type=code&redirect_uri=http://localhost:8000/callback&scope=user-read-currently-playing
Paste your code here:
```

Paste link in 2. to browser (if you are first time to this, you will be asked to login into Spotify to authorize this app to access your Spotify account), you should see something like:
```
{
  "msg":"Using this code to exchange access token 👇",
  "code":"AQCcIu9x....VKe"
}
```


Copy the code and paste it to prompt.
If success, you should see something like these:

```
ACCESS TOKEN:
 BQAD_...dgA

REFRESH TOKEN:
 AQC...rgk
```
You can also found ACCESS TOKEN and REFRESH_TOKEN were been written into `.env`

Finally, just run

`./app.zsh`

You should get what you are playing now :)

```
[200] title
```

By default, it will check every 10 seconds.
