#!/bin/bash

file1="./Files/test_file1"

#---------------------------------------------------------------------------------------------------
# Create and open a file
#---------------------------------------------------------------------------------------------------
touch samp_file && vim samp_file #if we are able to create samp_file then we want to open that file using vim


#---------------------------------------------------------------------------------------------------
# Analyse file
#---------------------------------------------------------------------------------------------------
# Checking if file exists
if [ -e "$file1" ]; then
	echo "$file1 exists"
fi

# Checking if file is normal
if [ -f $file1 ]; then
	echo "$file1 is a normal file"
fi

# Checking if file is USER readable
if [ -r $file1 ]; then
	echo "$file1 is readable"
fi

# Checking if file is USER writable
if [ -w "$file1" ]; then
	echo "$file1 is writable"
fi

# Checking if file is USER executable
if [ -x $file1 ]; then
	echo "$file1 is executable"
fi

# Checking if file is directory
if [ -d "$file1" ]; then
	echo "$file1 is directory"
fi

# Checking if file is directory
if [ -L "$file1" ]; then
	echo "$file1 is simbolic link"
fi


#---------------------------------------------------------------------------------------------------
# Create directory
#---------------------------------------------------------------------------------------------------
# if samp_dir doesn't exist than create it
#  - with option -d we check if directory exists
[ -d samp_dir ] || mkdir samp_dir
