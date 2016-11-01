tag?=develop

build:
	docker build --no-cache=true -t qoopido/php56:${tag} .