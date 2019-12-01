VERSION?=v1

build:
	docker build -t pdemagny/github-actions-ek8s-toolbox:$(VERSION) . -f Dockerfile

push:
	docker push pdemagny/github-actions-ek8s-toolbox:$(VERSION)

bp: build push