APP_NAME ?= local-lambda
IMAGE_NAME ?= $(APP_NAME):latest
ARCH ?= arm64

bootstrap:
	CGO_ENABLED=0 GOOS=linux GOARCH=$(ARCH) go build -o ./bin/bootstrap ./cmd/handler

clean:
	rm -f ./bin/bootstrap

.PHONY: docker-build

docker-build:
	docker build --build-arg TARGETARCH=$(ARCH) -t $(IMAGE_NAME) .

.PHONY: run

run:
	docker run --rm -p 9000:8080 $(IMAGE_NAME)

.PHONY: invoke

invoke:
	curl -s -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" \
	  -H 'Content-Type: application/json' \
	  -d @event.json | jq
