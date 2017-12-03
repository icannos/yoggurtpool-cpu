#!/bin/bash

if [ ! -d "build" ]
then
mkdir "build"
fi

if [ ! -d "bin" ]
then
mkdir "bin"
fi

cd "build"
cmake "../"
make

cd ../


for file in prog/*.s
do
    name=${file##*/}
    base=${name%.txt}
    python "asm.py" "$file" --output bin/"$name".obj
done

