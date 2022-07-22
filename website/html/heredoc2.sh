#!/bin/bash

# take the output from listing all files in the image directory and create
# a new txt file called imagelist.txt
ls images > imagelist.txt

# use new line as delimiter
IFS=$'\n'

# before starting, remove any existing file named replacement_images.txt
txt_file=replacement_images.txt
if [[ -f "$txt_file" ]]
then
	rm replacement_images.txt
fi

# loop thru the lines in the new imagelist.txt file to return the name of each image
# and insert HTML formatting, creating new file called replacement_images.txt
# and prefance each image file name with images\ directory
for line in $(cat ./imagelist.txt)
do
	echo "        <td><img src="\"images/"$line\" alt=\"\" border=3 height=100 width=300</th>" >> replacement_images.txt
done


# remove any existing file named temp_index.html
temp_html_file=temp_index.html
if [[ -f "$html_file" ]]
then
	rm temp_index.html
fi

# remove any existing file named index.html
html_file=index.html
if [[ -f "$html_file" ]]
then
	rm index.html
fi


# create the template index.html
cat << EOF > temp_index.html
<!doctype html>
<html>
  <head>
    <title>MIDS1D Challenge - Countless Pictures!</title>
  </head>
  <body>
    <center>
      <h1>MATH COLLECTION</h1>
    </center>

  <table border="5" bordercolor="red" align="center">
    <tr>
        <th colspan="3">SO MANY PICTURES!</th>
    </tr>
INSERT_HERE
  </table>
  </body>
</html>
EOF

# find the number of images in the /images folder
num_images=$(find ~/projects/MIDS1D/website/html/images -maxdepth 1 -type f | wc -l)

# specify number of columns needed in index.html file
columns=3

# use $num_images and $columns to calculate the number of iterations needed to create index.html template
iterations=$(($num_images / $columns))

# find INSERT_HERE in newly created index.html and add lines to be replaced by image filenames
while [ $iterations -gt 0 ]
do
	sed -i 's|INSERT_HERE|    <tr>\nreplace\nreplace\nreplace\n    </tr>\nINSERT_HERE|' temp_index.html
	((iterations=iterations-1))
done

# remove the remaining INSERT_HERE from index.html
sed -i 's|INSERT_HERE||' temp_index.html

# loop thru each line in index.html and replace "replace" with the top
# line in replacement_images.txt, followed by deleting the top line
set -x
line_num=1
#firstline=$(head -n 1 replacement_images.txt)
for line in $(cat temp_index.html)
do
declare firstline=$(head -n 1 replacement_images.txt)
	if [[ $line == "replace" ]]
	then
		echo $line >> index.html; sed -i "s,replace,$firstline," index.html; sed -i '1d' replacement_images.txt
	else
		echo $line >> index.html
	fi
#	if [[ $line == "replace" ]]
#	then
#		echo $firstline; sed -i '1d' replacement_images.txt
#		sed -i "s|table|,|replace|${firstline}|" index.html; sed -i '1d' replacement_images.txt
#		sed -i '/table/,/replace/$(sed -n ${line_num}p < replacement_images.txt)/' index.html; ((line_num+=1)); echo $line_num
#		 sed -i "s|${line}|        $(sed -n ${line_num}p < replacement_images.txt)|" index.html; ((line_num+=1)); echo $line_num
#	else
#		continue
#	fi
#	echo "<td><img src="\"images/"$line\ alt=\"\" border=3 height=100 width=300</th>" >> replacement_images.txt
done
