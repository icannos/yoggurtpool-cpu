#!/bin/bash

if [ ! -d "build" ]
then
mkdir "build"
fi

if [ ! -d "bin" ]
then
mkdir "bin"
fi

if [ ! -d "log" ]
then
mkdir "log"
fi

cd "build"
cmake "../"
make

cd ../

echo "Compiling Font..."
python compiler/bitmaptoascii.py compiler/font.bmp --output prog/font.mem
echo "Font built"

echo "Assembly..."
cd prog
for file in *.s
do
    name=${file##*/}
    base=${name%.txt}

    python "../compiler/asm.py" "$file" --output ../bin/"$name".obj > ../log/"$name".log
done
cd ../tetris

python ../compiler/asm.py tetris.s --output ../bin/tetris.obj
