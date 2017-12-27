#!/bin/bash


if [ ! -d "bin" ]
then
mkdir "bin"
fi

if [ ! -d "log" ]
then
mkdir "log"
fi

echo "Compiling Font..."
python compiler/bitmaptoascii.py compiler/font.bmp --output prog/font.mem
echo "Font built"

echo "Assembly..."
for file in prog/*.s
do
    name=${file##*/}
    base=${name%.txt}
    python "compiler/asm.py" "$file" --output bin/"$name".obj > log/"$name".log
done
