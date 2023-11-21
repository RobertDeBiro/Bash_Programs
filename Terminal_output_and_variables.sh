#!/bin/bash

#---------------------------------------------------------------------------------------------------
# Constants (MACRO)
#   - "r" means read-only
#---------------------------------------------------------------------------------------------------
declare -r MY_HEIGHT=187


#---------------------------------------------------------------------------------------------------
# Variables:
#   - when variable is assigned, there should be no empty space
#   - variable name must start with letter or underscore, and can also contain numbers
#   - when variable or MACRO is used, $ sign must be put in front of the variable name
#   - bash threats every value as a string, so when we want to declare string to a variable
#     we can put parenthesis, but we don't have to
#      - in both cases variable is considered as a string
#---------------------------------------------------------------------------------------------------
myName="Robert"
MyAge=29
MyHeight1=MY_HEIGHT
MyHeight2=$MY_HEIGHT


#---------------------------------------------------------------------------------------------------
# Command - echo
#   - text that we want to put on the terminal can be in in double quotes or without quotes
#      - it is good to use double quotes because of the \n option, but also because it is cleaner
#   - if text is in single quotes, everything inside is considered as string, so variable won't be called
#   - newline:
#      - if we want to put a newline together with some text, we need to use "-e" in a combination with \n
#      - if we only want to put a newline, we can use only echo, or echo -e
#---------------------------------------------------------------------------------------------------
echo "Command - echo:"

echo -e "Hi, I am $myName\n"
echo -e 'I am $MyAge years old \n'
echo -e I am $MyAge years old \n

echo

echo -e "My height1 is $MyHeight1 \n"
echo -e "My height2 is $MyHeight2 \n"
echo -e "My height is $MY_HEIGHT \n"

echo -e


#---------------------------------------------------------------------------------------------------
# Command - cat
#   - cat prints content of the file
#   - cat can also print random text by using "END" option
#---------------------------------------------------------------------------------------------------
echo "Command - cat:"
#cat ~/workspace/Computing_and_programming/Linux/Bash/Shell_Scripting_Tutorial_practice/0.Terminal_output

cat << END
This text
prints on
many lines
END

