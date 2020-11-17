all: build

build:
	docker build --target clang-format -t coldnew/clang-format:9 .

deploy:
	docker push coldnew/clang-format:9
