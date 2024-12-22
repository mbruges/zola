#!/bin/bash

# honestly no point - webp in COLOUR is smaller! MaYbe there's a better compression algo to use, I dunno.'

input="$1"
output="output"
colour1="rgb(49,49,49)"
colour2="rgb(255,252,228)"

magick -size 50x100 xc:"$colour1" xc:"$colour2" -append colors.png

# Process the input image
#convert "$input" -colorspace RGB -filter box -resize 700 -ordered-dither colors.png -strip -remap colors.png -colorspace sRGB -quality 100 png24:$output.png

convert "$input" -colorspace RGB -filter box -resize 700 -ordered-dither colors.png -strip -remap colors.png -colorspace sRGB -quality 100 $output.webp

#convert "$input" -resize 700 -strip -quality 30 $output.webp


# Clean up
#rm colors.png
ls -l "$input"
ls -l "$output.webp"
