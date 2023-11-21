#!/bin/bash

#---------------------------------------------------------------------------------------------------
# If-else statement
# - condition statement can be put into
#    - square brackets - when we want to put some random condition
#    - double parentheses - when we are using comparison or logical operators
# - if we want to put "then" in the same line with "if" we need to use semicolon between them
#---------------------------------------------------------------------------------------------------

##### 1. Example #####
echo -e "\n1. Example"

read -p "How old are you? " age

if [ $age -ge 16 ] #-ge means "greater then or equal to i.e. >=
then
	echo "You can drive."
elif [ $age -eq 15 ] #-eq means equal i.e. ==
then
	echo "You can drive next year."
else
	echo "You can't drive."
fi #with "fi" command we are closing if statement


##### 2. Example #####
echo -e "\n2. Example"
read -p "Enter a number : " num

if ((num == 10)); then
	echo "Your number equals 10."
fi

if ((num >= 10)); then
	echo "It is greater then or equal to 10."
else
	echo "It is less then 10."
fi

if (( ((num % 2)) == 0 ))
then
	echo "It is even"
fi


#---------------------------------------------------------------------------------------------------
# If-else statement version, with logical operators
#---------------------------------------------------------------------------------------------------
if (( ((num > 0)) && ((num < 11)) ));
then
	echo "$num is between 1 and 10"
fi
