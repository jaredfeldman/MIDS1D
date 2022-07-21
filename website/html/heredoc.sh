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
	echo "<td><img src="\"images/"$line\ alt=\"\" border=3 height=100 width=300</th>" >> replacement_images.txt
done


# remove any existing file named index.html
html_file=index.html
if [[ -f "$html_file" ]]
then
	rm index.html
fi

# create the template index.html
cat << EOF > index.html
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
	sed -i 's|INSERT_HERE|    <tr>\n        replace\n        replace\n        replace\n    </tr>\nINSERT_HERE|' index.html
	((iterations=iterations-1))
done

# remove the remaining INSERT_HERE from index.html
sed -i 's|INSERT_HERE||' index.html

# loop thru each line in index.html and replace "replace" with the top of each line in replacement_images.txt










 ## in case needed later - iterates and creates new index.html file

#echo -e "hello\nhello\nline3\nreplace\nreplace\nreplace" >> index.html


#while [ $iterations -gt 0 ]
#do
#	echo -e "    <tr>\nreplace\nreplace\nreplace\n    </tr>" >> index.html
#	((iterations=iterations-1))
#done
