############################################################
## fetch-source
############################################################
# NOTE:
# all source will fetch here and add to /build dir

FROM alpine:3.14 as fetch-source

ARG LLVM_TAG
ENV LLVM_TAG ${LLVM_TAG:-llvmorg-11.1.0}

# Build dependencies
RUN apk update && apk add git

# Download and setup, we move all build source to /build/llvm-project
WORKDIR /build
RUN git clone --branch ${LLVM_TAG} --depth 1 https://github.com/llvm/llvm-project.git
WORKDIR /build/llvm-project
RUN mv clang llvm/tools ; \
	mv libcxx llvm/projects ; \
	mv libcxxabi llvm/projects

############################################################
## build-env
############################################################

FROM alpine:3.14 as build-env

COPY --from=fetch-source /build /build

WORKDIR /build/llvm-project/llvm/build
RUN apk update && apk add build-base cmake ninja python3 git libstdc++; \
	cmake -GNinja -DLLVM_BUILD_STATIC=ON -DLLVM_ENABLE_LIBCXX=ON .. \
	&& ninja clang-format \
	&& strip bin/clang-format

############################################################
## clang-format
############################################################

FROM alpine:3.14 as clang-format

WORKDIR /workdir

COPY --from=build-env /build/llvm-project/llvm/build/bin/clang-format /usr/bin

RUN apk add --no-cache bash git
