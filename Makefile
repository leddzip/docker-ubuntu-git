image_name = leddzip/ubuntu-git
env_prefix = $$(bash ./build-scripts/build-env-prefix.sh)
ubuntu_tag = $$(bash ./build-scripts/get-ubuntu-tag.sh)


.ONESHELL:
SHELL = /bin/bash
generate-dockerfile:
	echo "export INJECT_UBUNTU_DOCKER_TAG=$(ubuntu_tag)" > args
	source args
	envsubst "`printf '$${%s} ' $$(cat args | cut -d' ' -f2 | cut -d'=' -f1)`" < Dockerfile.template > Dockerfile

.ONESHELL:
SHELL = /bin/bash
build:
	source args
	docker build \
		-t $(image_name):$(env_prefix)$(ubuntu_tag) \
		.

.ONESHELL:
SHELL = /bin/bash
push:
	source args
	docker push $(image_name):$(env_prefix)$(ubuntu_tag)

.ONESHELL:
SHELL = /bin/bash
clean:
	source args
	docker rmi $(image_name):$(env_prefix)$(ubuntu_tag)
	rm Dockerfile
	rm args


.ONEHSELL:
SHELL = /bin/bash
test:
	source args
	bash ./build-scripts/test-ubuntu-version.sh $(image_name):$(env_prefix)$(ubuntu_tag)
	bash ./build-scripts/test-git.sh $(image_name):$(env_prefix)$(ubuntu_tag)
