#!/bin/bash

str1=""
str2="Sad"
str3="Happy"

if [ $str1 ]; then
	echo "$str1 is not null"
fi

if [ !$str1 ]; then
	echo "str1 is null"
fi

if [ -z "$str1" ]; then # with option -z we are checking that our string hasn't got any value
	echo "str1 has no value"
fi

if [ "$str2" == "$str3" ]; then
	echo "$str2 equals $str3"
else
	echo "$str2 is not equal to $str3"
fi
