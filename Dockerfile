FROM ubuntu:trusty 
 
RUN apt-get update 
RUN apt-get -y install expect redis-server nodejs npm 
RUN ln -s /usr/bin/nodejs /usr/bin/node 
 
RUN npm install -g coffee-script 
RUN npm install -g yo generator-hubot 
 
# Create hubot user 
RUN useradd -d /hubot -m -s /bin/bash -U hubot 
 
# Log in as hubot user and change directory 
USER    hubot 
WORKDIR /hubot 
 
RUN yo hubot --owner="move" --name="shard04" --description="shard04 in Docker" --defaults 
 
RUN npm install hubot-slack --save && npm install 

CMD bin/hubot --adpater slack
