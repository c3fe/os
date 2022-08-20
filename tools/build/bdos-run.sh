#!/usr/bin/env bash

# set -x

die() {
	echo "$1"
	exit 1
}

[ -z "$1" ] && die "Usage: $(basename $0) <command>"
podman run --rm -it --security-opt label=disable -v $PWD:/build \
       -w /build \
       bored0m-devel:latest /bin/bash -c "$*"

