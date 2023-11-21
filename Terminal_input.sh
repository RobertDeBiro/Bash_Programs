#!/bin/bash

#---------------------------------------------------------------------------------------------------
# Receive input from the user: command read
# - read command is used for reading from terminal
#---------------------------------------------------------------------------------------------------
echo "What is your first name?"
read first_name
echo -e "Hi $first_name\n"


##### Receive input from the user, with prompt #####
# - with -p option (prompt) we can first print something to terminal and than read from it
read -p "What is your second_name? " second_name
echo -e "Hi $first_name $second_name\n"


##### Receive multiple inputs from the user, with prompt #####
read -p "Enter 2 numbers to sum: " num1 num2
sum=$((num1+num2))
echo -e "$num1 + $num2 = $sum\n"


##### Receive secret input from the user, with prompt #####
# - with -sp option we can hide input
# - secret input is mainly used for password
read -sp "Enter password: " password
echo -e "\nEntered password = $password"
