.PHONY: all help build run builddocker rundocker kill rm-image rm clean enter logs

all: help

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

build: NAME TAG builddocker

# run a plain container
run: rm rundocker

rundocker:
	$(eval NAME := $(shell cat NAME))
	$(eval TAG := $(shell cat TAG))
	@docker run --name=$(NAME) \
	--cidfile="cid" \
	--env-file=env \
	-t $(TAG)

# run a container with a mounted TMP
# useful for debugging and getting the config out to test it
tmp: build rm rundockerwtmp

rundockerwtmp:
	$(eval TMP := $(shell mktemp -d --suffix=DOCKERTMP))
	$(eval NAME := $(shell cat NAME))
	$(eval TAG := $(shell cat TAG))
	@docker run --name=$(NAME) \
	--cidfile="cid" \
	-v $(TMP):/tmp \
	--env-file=env \
	-t $(TAG)

# pull the latest copy from docker hub
pull:
	docker pull `cat TAG`

# build the container locally
builddocker:
	/usr/bin/time -v docker build -t `cat TAG` .

kill:
	-@docker kill `cat cid`

rm-image:
	-@docker rm `cat cid`
	-@rm cid

rm: kill rm-image

clean: rm

enter:
	docker exec -i -t `cat cid` /bin/bash

logs:
	docker logs -f `cat cid`

env:
	cp -i emr.env.example env
