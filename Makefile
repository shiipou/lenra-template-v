PROJECT_NAME ?= $(shell cat ${PWD}/v.mod | grep name | cut -d':' -f2 | xargs)
VERSION ?= $(shell cat ${PWD}/v.mod | grep version | cut -d':' -f2 | xargs)
ENV ?= 'dev'

build: check
	@mkdir -p "${PWD}/out/"
	v $([ "$ENV" == 'prod' ] && echo '-prod') -o "out/${PROJECT_NAME}" .

check:
	@v fmt -c .

format:
	@v fmt -w .

version:
	@echo ${VERSION}

print_name:
	@echo ${PROJECT_NAME}

run:
	@v -cg run .

dev:
	@v -cg watch .
