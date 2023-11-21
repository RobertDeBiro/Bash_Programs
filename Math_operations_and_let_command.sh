#!/bin/bash

declare -r NUM_MACRO=5

#---------------------------------------------------------------------------------------------------
# Mathematical operations and let command
# - when executing some mathematical operations, we use "$" sign and double parentheses:
#   $(( operation ))
#    - we need to use that syntax because every variable actually contains string value, so we need
#      to say somehow that we need that string to be considered as a integer, so that we can do
#      mathematical operation on it
#    - therefore, if we don't use $(( )) syntax when trying to do some mathematical operations,
#      everything written in mathematical operation will be considered as a string
#  - we can also use let command when executing mathematical operation
#---------------------------------------------------------------------------------------------------
num=5

result=$((num+4))
echo -e "No let:\nnum+4 = $result\n"

let result=num+3
echo -e "let:\nnum+3 = $result\n"

num=num+2
echo -e "num+2 without $(()) is: $num\n"


#---------------------------------------------------------------------------------------------------
# Arithmetic operators: +, -, *, /, **, %
#---------------------------------------------------------------------------------------------------
num=4
echo -e "Basic arithmetic operations: +, - *, /, ^, %:"

result=$((NUM_MACRO+num))
echo 5 + 4 = $result # Double quotes are not mandatory!

result=$((NUM_MACRO-num))
echo "5 - 4 = $result"

result=$((NUM_MACRO*num))
echo "5 * 4 = $result"

result=$((NUM_MACRO/num))
echo "5 / 4 = $result"

echo "5 ^ 2 = $((5**2))" # This is equal to 5^2
echo "5 % 4 = $(( 5%4 ))" # We can set white spaces inside parantheses - there is no difference

##### Addition of floating point numbers #####
echo -e "\nAddition of floating point numbers:"
frac1=1.2
frac2=3.4
result_pyt=$(python -c "print $frac1+$frac2") # for adding floating point numbers e need to use python scipt
echo "1.2 + 3.4 = $result_pyt"

# Floating point numbers addition, without using python script, generates syntax error:
# invalid arithmetic operator (error token is ".2+3.4")
#result=$(($frac1+$frac2))


#---------------------------------------------------------------------------------------------------
# Increment and decrement operators: ++, --
#---------------------------------------------------------------------------------------------------
echo -e "\nIncrement and decrement operations:"

incdec=10
echo "incdec++ = $(( incdec++ ))"
echo "++incdec = $(( ++incdec ))"
echo "incdec-- = $(( incdec-- ))"
echo "--incdec = $(( --incdec ))"


#---------------------------------------------------------------------------------------------------
# Assignment operators: +=, -=, *=, /=
#---------------------------------------------------------------------------------------------------
echo -e "\nAssignment operators:"

# When using assignment operator, omitting $(( )) will result with string concatenation
# - bash executes string concatenation since it threats every variable as string
num=1
num+=2
echo "num+=2 = $num" # result is num = 12
                     #  - 2 is concatenated to previous value of num, which is 1

num=5

$((num+=2))
echo "num+=2 = $num"

let num-=4
echo "num-=4 = $num"

let num*=2
echo "num*=2 = $num"

let num/=3
echo "num/=3 = $num"
