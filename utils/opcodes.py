#!/usr/bin/env python

import re

f = open("opcodes.txt", "r")

c_array = ""

for l in f.readlines():
    tokens = re.findall('[\S]+', l)

    c_array += 'instr[' + str(int(str(tokens[0]), 2)) + '] = string("' + str(tokens[1]) +'") ; \n'



f.close()


f = open("opcode_array.txt", "w")
f.write(c_array)
f.close()
