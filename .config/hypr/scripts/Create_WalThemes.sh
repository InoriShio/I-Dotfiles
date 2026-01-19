#!/bin/zsh

rm -rf /home/inorishio/.cache/wal/schemes/*

for file in /home/inorishio/Pictures/Backgrounds/*; do
    wal -i "$file" -n -b '#000000' -I cursor
done
for file in /home/inorishio/.cache/wal/schemes/*; do
   name="$(basename "$file" | sed 's/^_home_inorishio_Pictures_Backgrounds_//' | sed 's/_.*$//')"
  mv "$file" /home/inorishio/.cache/wal/schemes/"$name".json
done
