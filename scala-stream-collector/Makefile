help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""  This is merely a base image for usage read the README file
	@echo ""   1. make run       - run docker container
	@echo ""   2. make build     - build docker container
	@echo ""   3. make clean     - kill and remove docker container
	@echo ""   4. make enter     - execute an interactive bash in docker container
	@echo ""   5. make logs      - follow the logs of docker container
	@echo ""   6. make pull      - pull the latest docker container

build: TAG builddocker

# run a plain container
run: NAME TAG env rm .scala-collector.CID

.scala-collector.CID:
	$(eval NAME := $(shell cat NAME))
	$(eval TAG := $(shell cat TAG))
	@docker run -d --name=$(NAME) \
	--cidfile=".scala-collector.CID" \
	--env-file=env \
	-t $(TAG)

# pull the latest copy from docker hub
pull:
	docker pull `cat TAG`

# build the container locally
builddocker:
	/usr/bin/time -v docker build -t `cat TAG` .

kill:
	-@docker kill `cat .scala-collector.CID`

rm-image:
	-@docker rm `cat .scala-collector.CID`
	-@rm .scala-collector.CID

rm: kill rm-image

clean: rm

enter:
	docker exec -i -t `cat .scala-collector.CID` /bin/bash

logs:
	docker logs -f `cat .scala-collector.CID`

env:
	cp -i collector.env.example env

NAME:
	echo scala-stream-collector > NAME

TAG:
	echo 'snowplow/scala-stream-collector' > TAG
