#!/bin/bash

# take the output from listing all files in the image file and create a new txt file called imagelist.txt
ls images > imagelist.txt

# use new line at delimiter
IFS=$'\n' 

# loop thru the lines in the new imagelist.txt file to return the name of each image
for line in $(cat ./imagelist.txt)
do
	echo "<td><img src="\"images/"$line\" alt=\"\" border=3 height=100 width=300></th>" >> replacement_images.txt #preface each image file name with directory name images\
done
