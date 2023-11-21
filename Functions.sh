#!/bin/bash

#---------------------------------------------------------------------------------------------------
# Trivial function as first example
#---------------------------------------------------------------------------------------------------
echo "Printing date and time:"
getDate(){
  date #date function prints date and time

  return
}

getDate # function call


#---------------------------------------------------------------------------------------------------
# Local and global variables
# - when declaring local variable we must use keyword "local"
#---------------------------------------------------------------------------------------------------
echo -e "\nDemonstrating global and local variables:"

name="Robert" #global variable

demLocal(){
  local name="Martina"
  echo "Local name = $name"

  return
}

demLocal

echo "Global name = $name"


#---------------------------------------------------------------------------------------------------
# Function receives attributes and returns result
# - there is no need to add parameters in function definition
#    - paremeters are fetched by using "$parameter" syntax
# - arguments to function are passed without parentheses and commas
# - result is returned from the function with "echo"
#---------------------------------------------------------------------------------------------------
echo -e "\nFunction that receives 2 attributes and returns back the output:"

getSum(){
	
	local num3=$1 # $1 presents first input parameter
	local num4=$2 # $2 presents second input parameter

	local sum=$((num3+num4))

	echo $sum
}

num1=5
num2=6

sum=$(getSum num1 num2)
echo "The sum is $sum"
