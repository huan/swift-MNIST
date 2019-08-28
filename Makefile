# Makefile for awesome-chatboot
# Author: Huan LI <zixia@zixia.net> github.com/huan

SOURCE_GLOB=$(wildcard bin/*.py chit-chat/*.py tests/*.py)

.PHONY: all
all : clean lint

.PHONY: clean
clean:
	echo "TODO: clean what?"

.PHONY: lint
lint: pylint pycodestyle flake8 mypy

.PHONY: docker
docker:
	docker run -ti --rm \
		--privileged \
		--userns=host \
		-v "$$(pwd)":/notebooks \
		zixia/swift \
		bash

.PHONY: test
test:
	swift test

.PHONY: code
code:
	code .
