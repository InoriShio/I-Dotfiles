#!/bin/zsh

dir="/home/inorishio/Pictures/Backgrounds/"
output_file="/tmp/random_images.list"
images=10

# Generate random images
find "$dir" -type f | shuf -n $images > "$output_file"
