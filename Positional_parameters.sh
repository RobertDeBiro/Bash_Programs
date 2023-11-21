#!/bin/bash

#---------------------------------------------------------------------------------------------------
# Positional parameters
# - positional parameters are variables that can store data on the command line in variable names 0 - 9
#    a. $0 always contains the path to the executed script
#    b. You can access names past 9 by using parameter expansion like this ${10}
#---------------------------------------------------------------------------------------------------
##### Add all numbers on the command line #####
# Print the first argument
echo "1st Argument : $1"

sum=0

while [[ $# -gt 0 ]]; do # $# tells us the number of arguments

	# Get the first argument
	num=$1
	sum=$((sum + num))

	shift # shift moves the value of $2 into $1 until none are left
		  # the value of $# decrements as well
done

echo "Sum : $sum"
