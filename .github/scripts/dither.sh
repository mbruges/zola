#!/bin/bash

# honestly no point - webp in COLOUR is smaller!

input="$1"
output="output.gif"
colour1="rgb(22,27,43)"
colour2="rgb(255,252,228)"

magick -size 50x100 xc:"$colour1" xc:"$colour2" -append colors.png

# Process the input image
magick "$input" -colorspace RGB -dither Ordered -strip -remap colors.png -threshold 50%  -quality 100 "$output"

# Clean up
#rm colors.png
ls -l "$input"
ls -l "$output"
