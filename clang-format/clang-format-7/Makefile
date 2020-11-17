all: build

build:
	docker build --target clang-format -t coldnew/clang-format:7 .

deploy:
	docker push coldnew/clang-format:7
