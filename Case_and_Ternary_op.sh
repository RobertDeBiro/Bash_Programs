#!/bin/bash

#---------------------------------------------------------------------------------------------------
# Case statement
#---------------------------------------------------------------------------------------------------

read -p "How old are you : " age

case $age in

[0-5]) # Match numbers 0 - 4
	echo "To young for school"
	;; # Stop checking further
	
6) # Match only 5
	echo "Go to preschool"
	;;
	
# We need to use following syntax because RegEx for numbers scope supports only one digit,
# i.e. numbers from 0 to 9
[7-9]|1[0-4]) # Check 7 - 14
	grade=$((age-6))
	echo "Go to grade $grade"
	;;

1[5-8]) # Check 15 - 18
	grade=$((age-14))
	echo "Go to grade $grade of Hihgschool"
	;;
	
*) # Default action
	echo "You are to old for school"
	;;
esac # End case


#---------------------------------------------------------------------------------------------------
# Ternary operator
#---------------------------------------------------------------------------------------------------
can_vote=0
age=18

((age >= 18 ? (can_vote=1) : (can_vote=0)))
echo "Can Vote : $can_vote"
