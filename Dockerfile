FROM alpine:3.11

LABEL maintainer="vansteki.tw@gmail.com"

RUN apk add --update zsh nodejs npm curl && npm install -g fx

COPY . /src

WORKDIR /src

EXPOSE 8000

ENTRYPOINT ["zsh", "./app.zsh"]
