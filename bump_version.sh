#!/bin/bash
#-*- mode: Shell-script -*-

if [ ! $# = 1 ]; then
	echo usage: $0 VERSION
	exit
fi
VERSION=$1

echo ${VERSION} > VERSION

