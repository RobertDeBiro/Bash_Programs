#!/bin/bash

#---------------------------------------------------------------------------------------------------
# IFS handling
#  - IFS (Internal Field Separator) is a special shell variable used for word splitting with the
#    builtin command read.
#  - the default value is <space><tab><newline>
#     - means that, when we are executing read command, every space, tab or newline will be
#       discarded by default
#---------------------------------------------------------------------------------------------------

echo "IFS default value: $IFS"

# Save default IFS value in OIFS
OIFS="$IFS"

# Change IFS value from space/tab/newline to ","
#  - now, when executing read command, "," will be discarded
IFS=","

echo "IFS new value: $IFS"

read -p "Enter 2 numbers to add separated by a comma: " num1 num2

IFS="$OIFS"

#---------------------------------------------------------------------------------------------------
# Parameter expansion
# - syntax: ${}
# - with parameter expansion we can:
#    - expand parameter: ${parameter}<expansion>
#    - substitute parts of parameter: ${parameter//part/substitution}
#    - create new variable if it doesn't exist, or use existing value if it exists
#---------------------------------------------------------------------------------------------------

##### Substitute parts of parameter #####
# Substitute any blank character (whitespace) with nothing, i.e. remove whitespace from num1 and num2
num1=${num1//[[:blank:]]/}
num2=${num2//[[:blank:]]/}

sum=$((num1 + num2))
echo "$num1 + $num2 = $sum"

samp_string="The dog climbed the tree"
echo "${samp_string//dog/cat}"


##### Expand parameter #####
MyName="Robert"
echo Hi $MyName
echo "${MyName}'s toy"


##### Create new variable if it doesn't exist, or use existing value if it exists #####
echo "I am ${MyName:=DeBiro}" # MyName exists so Robert is used
echo "I am ${Name:=DeBiro}" # Name doesn't exists, so it is created and assigned to "DeBiro"


#---------------------------------------------------------------------------------------------------
# Parameter expansion with strings
#---------------------------------------------------------------------------------------------------
rand_str="A random string"

# Get string length
echo "String Length : ${#rand_str}"

# Get string slice starting at index 2
echo "${rand_str:2}"

# Get string slice starting at index 2 and ending at index 7
echo "${rand_str:2:7}"

# Get string slice after "A "
echo "${rand_str#*A }"
