#!/bin/bash

# take the output from listing all files in the image file and create a new txt file called imagelist.txt
ls images > imagelist.txt

# use new line at delimiter
IFS=$'\n' 

# loop thru the lines in the new imagelist.txt file to return the name of each image and then replace the name in html
for line in $(cat ./imagelist.txt)
do
	sed "s/<td>\(.*\)<\/th>/<td><img src='\'images\/'$line\' alt=\'\' border=3 height=100 width=300><\/th>/" index.html
done


# now loop thru the index.html file and find each and replace with filename
#replaceline='<td>\(.*\)</th>'
#for line in $(cat ./index.html)
#do
#	if [ $line = $replaceline ]
#	then
#		sed 's/$replaceline/hello/'
#		echo "hi"
#	fi
#done

# indicate the matching line and use leading spaces
match="    </tr>"
replace="    hello"

# for every line in the index.html file, find line that matches $match and replace with sed
for line in $(cat ./index.html)
do
	if [ $line = $match ]
	then
		sed "s|$line|$replace|" index.html
	fi
done


# test sed to replace only the URL
# sed  s/<td>\(.*\)<\/th>/hello/' index.html
