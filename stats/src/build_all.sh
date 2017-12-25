#!/bin/bash


echo "Assembly..."
for file in *.ss
do
    name=${file##*/}
    base=${name%.txt}
    python "asm.py" "$file" --output "$base".obj
done
