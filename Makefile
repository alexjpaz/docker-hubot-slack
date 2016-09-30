build:
	docker build -t alexjpaz.com/hubot-slack:latest .

run: build
	docker run alexjpaz.com/hubot-slack:latest

runIt: build
	docker run -it \
		--entrypoint /bin/sh \
		alexjpaz.com/hubot-slack:latest
