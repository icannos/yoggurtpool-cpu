#!/bin/bash


echo "Assembly..."
for file in *.obj
do
    name=${file##*/}
    base=${name%.txt}
    ../../bin/simu.exe -h "$file" | python2 huffman.py
done
