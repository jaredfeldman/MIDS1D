#!/bin/bash

#echo -e "hello\nhello\nline3\nreplace\nreplace\nreplace" >> index.html

num_images=$(find ~/projects/MIDS1D/website/html/images -maxdepth 1 -type f | wc -l)
columns=3
iterations=$(($num_images / $columns))

echo $num_images
echo $iterations
echo $columns

#while [ $d -gt 0 ]
#do
#	echo -e "replace\nreplace\nreplace\n" > index.html
#	((d=d-1))
#done

