#!/bin/bash

#---------------------------------------------------------------------------------------------------
# While loop
#---------------------------------------------------------------------------------------------------
num=1

while [ $num -le 10 ]; do
	echo $num
	num=$((num + 1))
done

##### Continue and Break #####
num=1

while [ $num -le 20 ]; do

	# Don't print evens
	if (( ((num % 2)) == 0 )); then
		num=$((num + 1))
		continue
	fi
	
	# Jump out of the loop with break
	if ((num >= 15)); then
		break
	fi
	
	echo $num
	num=$((num + 1))
done


##### Input a file data in while loop #####
# - using read in this form is the same as using it when inserting values from terminal
#   (check Terminal_input file), but, this time data is read from the file
while read avg rbis hrs; do

	printf "Avg: ${avg}\nRBIs: ${rbis}\nHRs: ${hrs}\n" # printf allows us to use \n

done < Files/barry_bonds.txt # Pipe data into the while loop



#---------------------------------------------------------------------------------------------------
# Until loop
# - until is similar to while, but it has opposite logic
#---------------------------------------------------------------------------------------------------
num=1

until [ $num -gt 10 ]; do
	echo $num
	num=$((num + 1))
done



#---------------------------------------------------------------------------------------------------
# For loop
# - there are many "for loop" options, e.g. c form, cycle through ranges etc.
#---------------------------------------------------------------------------------------------------
##### C form #####
for (( i=0; i <= 10; i=i+1 )); do
	echo $i
done

##### Cycle through ranges #####
for i in {A..Z}; do
	echo $i
done
