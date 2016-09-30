FROM mhart/alpine-node:6

RUN apk add --no-cache expect

RUN npm install -g coffee-script
RUN npm install -g yo generator-hubot

RUN adduser -h /hubot -D -s /bin/bash hubot

# Log in as hubot user and change directory
USER    hubot
WORKDIR /hubot

ARG hubot_name=NO_OWNER
ARG hubot_owner=NO_NAME

RUN yo hubot --owner="${hubot_owner}" --name="${hubot_name}" --description="${hubot_name} in Docker" --defaults

RUN npm install hubot-slack

ENTRYPOINT ["bin/hubot","--adapter","slack"]
