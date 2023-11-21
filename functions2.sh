#!/bin/bash

findPattern() {
	echo $#
	for var in "$@"
	do
		echo "$var"
	done
}

if declare -f "$1" > /dev/null
then
	#call arguments verbatim
	"$@"
else
	# Show a helpful error
  echo "'$1' is not a known function name" >&2
  exit 1
fi
