VERSION?=v1

build:
	docker build -t mechtron/github-actions-ek8s-toolbox:$(VERSION) . -f Dockerfile

push:
	docker push mechtron/github-actions-ek8s-toolbox:$(VERSION)

bp: build push
