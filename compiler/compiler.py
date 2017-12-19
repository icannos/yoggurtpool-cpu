#!/usr/bin/env python

import os
import sys
import argparse
import tatsu
from grammar import GRAMMAR
from parser import CalcWalker


if __name__ == '__main__':

    argparser = argparse.ArgumentParser(description='This is the compiler for the "Max Langage" built for the ASR2017 processor @ ENS-Lyon')

    argparser.add_argument('--expr_addr', type=int,
                           help='Begin of the addresses in the memory where we store the intermediate results when we calcul an expr Default value = ')

    argparser.add_argument('--vars_addr', type=int,
                           help='Begin of the addresses in the memory where we store variables. Default value = ')

    argparser.add_argument('filename',
                           help='name of the source file.  "python asm.py toto.max" compile toto.max into toto.obj')



    options = argparser.parse_args()

    # Compiler
    walker = CalcWalker()
    parser = tatsu.compile(GRAMMAR, asmodel=True)

    # Open the src file
    basefilename, extension = os.path.splitext(options.filename)
    assembly_file = basefilename + ".s"

    infile = open(options.filename)
    src = infile.read()
    infile.close()

    src = parser.parse(src)

    outfile = open(assembly_file, "w")
    outfile.write(walker.walk(src))
    outfile.close()
