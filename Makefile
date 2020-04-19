ENV_FILE := .env
include ${ENV_FILE}
export $(shell sed 's/=.*//' ${ENV_FILE})
CURRENT_DIR = $(shell pwd)
IMAGE_REPO := quay.io/rhdevelopers
APP_VERSION := $(shell bash -c "xml sel -N ns='http://maven.apache.org/POM/4.0.0' -t -v '//ns:project/ns:version/text()' $(CURRENT_DIR)/pom.xml")
NATIVE_BULID_ARGS = -DskipTests -Dquarkus.native.native-image-xmx=6G -Dquarkus.native.container-build=true -Dquarkus.package.type=native package

.PHONY: start_docker
start_docker:
	@./bin/start-docker.sh

clean:
	@mvn clean 

target/*-runner.jar:	
	@mvn -DskipTests clean install

build:	clean	target/*-runner.jar

target/*-runner:	build
	@mvn -Pnative $(NATIVE_BULID_ARGS)

jvm_image_build_push:	build	
	@$(CONTAINER_CMD) build -t "$(IMAGE_REPO)/blue-green-canary:$(APP_TAG)-jar" -f src/main/docker/Dockerfile.jvm .
	@$(CONTAINER_CMD) push "$(IMAGE_REPO)/blue-green-canary:$(APP_TAG)-jar"
	@$(CONTAINER_CMD) tag "$(IMAGE_REPO)/blue-green-canary:$(APP_TAG)-jar" $(IMAGE_REPO)/blue-green-canary:$(APP_TAG)
	@$(CONTAINER_CMD) push "$(IMAGE_REPO)/blue-green-canary:$(APP_TAG)"

native:	target/*-runner

native_image_build_push:	native	
	@$(CONTAINER_CMD) build -t "$(IMAGE_REPO)/blue-green-canary:$(APP_TAG)" -f src/main/docker/Dockerfile.jvm .
	@$(CONTAINER_CMD) push $(IMAGE_REPO)/blue-green-canary:"$(APP_TAG)-native"
	@$(CONTAINER_CMD) tag $(IMAGE_REPO)/blue-green-canary:"$(APP_TAG)-native" $(IMAGE_REPO)/blue-green-canary:$(APP_TAG)
	@$(CONTAINER_CMD) push $(IMAGE_REPO)/blue-green-canary:$(APP_TAG)

all: clean jvm_image_build_push
