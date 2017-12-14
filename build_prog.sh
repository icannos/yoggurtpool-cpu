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
python compilateur/bitmaptoascii.py compilateur/font.bmp --output prog/font.mem
echo "Font built"

echo "Assembly..."
for file in prog/*.s
do
    name=${file##*/}
    base=${name%.txt}
    python "asm.py" "$file" --output bin/"$name".obj > log/"$name".log
done
