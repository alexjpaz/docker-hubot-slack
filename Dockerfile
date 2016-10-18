FROM mhart/alpine-node:6

RUN apk add --no-cache expect

# https://github.com/npm/npm/issues/13306
RUN cd $(npm root -g)/npm \
  && npm install fs-extra \
  && sed -i -e s/graceful-fs/fs-extra/ -e s/fs.rename/fs.move/ ./lib/utils/rename.js

RUN npm install -g coffee-script
RUN npm install -g yo generator-hubot

RUN adduser -h /hubot -D -s /bin/bash hubot

# Log in as hubot user and change directory
USER    hubot
WORKDIR /hubot

ARG hubot_name=NO_OWNER
ARG hubot_owner=NO_NAME

RUN yo hubot --owner="${hubot_owner}" --name="${hubot_name}" --description="${hubot_name} in Docker" --defaults

RUN npm install hubot-slack@4.0.2

ENTRYPOINT ["bin/hubot","--adapter","slack"]
