#!/bin/bash

cd max

for file in *.max
do
    name=${file##*/}
    base=${name%.txt}

    python "../compiler/compiler.py" "$file"
done

for file in *.s
do
    name=${file##*/}
    base=${name%.txt}

    python "../compiler/asm.py" "$file" --output ../bin/"$name".obj
done
