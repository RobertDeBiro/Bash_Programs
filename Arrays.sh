#!/bin/bash

#---------------------------------------------------------------------------------------------------
# Arrays
# - bash arrays can only have one dimension and indexes start at 0 by default
#---------------------------------------------------------------------------------------------------
##### Create an array #####
fav_nums=(3.14 2.718 .57721 4.6692)
echo "Pi : ${fav_nums[0]}"


##### Add value to array #####
fav_nums[4]=1.618
echo "GR : ${fav_nums[4]}"

##### Add group of values to array #####
fav_nums+=(1 7)


##### Output all array values #####
# - this is another "for loop" option
for i in ${fav_nums[*]}; do
	echo $i;
done

##### Output indexes #####
for i in ${!fav_nums[@]}; do
	echo $i;
done


##### Get number of items in array #####
echo "Array Length : ${#fav_nums[@]}"

##### Get length of array element #####
echo "Index 3 length : ${#fav_nums[3]}"


##### Sort an array #####
sorted_nums=($(for i in "${fav_nums[@]}"; do
	echo $i;
done | sort))

for i in ${sorted_nums[*]}; do
	echo $i;
done


##### Delete array element #####
unset 'sorted_nums[1]'

##### Delete Array #####
unset sorted_nums
