#!/bin/bash

# take the output from listing all files in the image directory and create
# a new txt file called imagelist.txt
ls images > imagelist.txt

# use new line as delimiter
IFS=$'\n'

# before moving forward to avoid overwriting or duplication, remove any existing file named replacement_images.txt
txt_file=replacement_images.txt
if [[ -f "$txt_file" ]]
then
	rm replacement_images.txt
fi

# loop through the lines in the new imagelist.txt file to return the name of each image
# and insert HTML formatting, creating new file called replacement_images.txt
# and prefance each image file name with images\ directory
for line in $(cat ./imagelist.txt)
do
	echo "        <td><img src="\"images/"$line\" alt=\"\" border=3 height=100 width=300</th>" >> replacement_images.txt
done


# before moving forward to avoid overwriting or duplication, remove any existing file named temp_index.html
temp_html_file=temp_index.html
if [[ -f "$html_file" ]]
then
	rm temp_index.html
fi

# before moving forward to avoid overwriting or duplication, remove any existing file named index.html
html_file=index.html
if [[ -f "$html_file" ]]
then
	rm index.html
fi


# create the template temp_index.html with all formatting set up, not including the image file names
# the INSERT_HERE block will be used to populate with image file names
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

# use $num_images and $columns to calculate the number of iterations needed to create temp_index.html template
# so that all images can be included
iterations=$(($num_images / $columns))

# find INSERT_HERE in newly created index.html and add lines to be replaced by image filenames
# we will replace with blocks of 3 between <tr> and </tr>
while [ $iterations -gt 0 ]
do
	sed -i 's|INSERT_HERE|    <tr>\nreplace\nreplace\nreplace\n    </tr>\nINSERT_HERE|' temp_index.html
	((iterations=iterations-1))
done

# remove the remaining INSERT_HERE from index.html created on last iteration above
sed -i 's|INSERT_HERE||' temp_index.html

# loop thru each line in temp_index.html and create a new index.html file, adding each line as we go
# when the line hits the newly add "replace" string, we will replace it with the top line of replacement_images.txt
# after replacement, we will delete the first line of replacement_images.txt so that the next iteration will find a 
# different image at the top of the file
for line in $(cat temp_index.html)
do
declare firstline=$(head -n 1 replacement_images.txt)
	if [[ $line == "replace" ]]
	then
		echo $line >> index.html; sed -i "s,replace,$firstline," index.html; sed -i '1d' replacement_images.txt
	else
		echo $line >> index.html
	fi
done
