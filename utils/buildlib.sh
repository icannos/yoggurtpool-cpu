#!/bin/bash

# Build a library from a directory
COMPILER_DIR = ../../compiler/includes_asm.py
python  ${COMPILER_DIR}  *.s  --prefix --exclusions $(ls -1 | sed -e 's/\..*$//') >  $(basename $(pwd)).sl
